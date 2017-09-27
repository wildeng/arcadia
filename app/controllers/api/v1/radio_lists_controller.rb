module Api
  module V1
    # Controller that manages all the radio stream
    # @author Alain Mauri
    # @version 0.1
    class RadioListsController < BaseController
      # before_filter :start_connection
      # after_filter  :stop_connection
      before_action :find_active_stream

      def index
        @radio_lists = RadioList.all
        response = {
          current_stream_id: @current_stream_id,
          radio_list: @radio_lists
        }
        respond_with(response)
      end

      # GET /radio_lists/1
      # GET /radio_lists/1.json
      def show
        @radio_list = RadioList.find(api_radio_params[:id])
        response = {
          current_stream_id: @current_stream_id,
          radio_list: @radio_list
        }
        respond_with(response)
      end

      # GET /radio_lists/new
      # GET /radio_lists/new.json
      def new
        @radio_list = RadioList.new
        response = {
          current_stream_id: @current_stream_id,
          radio_list: @radio_list
        }
        respond_with(response)
      end

      # GET /radio_lists/1/edit
      def edit
        @radio_list = RadioList.find(api_radio_params[:id])
      end

      # POST /radio_lists
      # POST /radio_lists.json
      def create
        @radio_list = RadioList.new(radio_params[:radio_list])

        respond_to do |format|
          if @radio_list.save
            format.html do
              redirect_to @radio_list,
                          notice: 'Radio list was successfully created.'
            end
            format.json do
              render json: @radio_list,
                     status: :created,
                     location: @radio_list
            end
          else
            format.html { render action: 'new' }
            format.json do
              render json: @radio_list.errors,
                     status: :unprocessable_entity
            end
          end
        end
      end

      # PUT /radio_lists/1
      # PUT /radio_lists/1.json
      def update
        @radio_list = RadioList.find(radio_params[:id])

        respond_to do |format|
          if @radio_list.update_attributes(radio_params[:radio_list])
            format.html do
              redirect_to @radio_list,
                          notice: 'Radio list was successfully updated.'
            end
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json do
              render json: @radio_list.errors,
                     status: :unprocessable_entity
            end
          end
        end
      end

      # DELETE /radio_lists/1
      # DELETE /radio_lists/1.json
      def destroy
        @radio_list = RadioList.find(radio_params[:id])
        @radio_list.destroy

        respond_to do |format|
          format.html { redirect_to radio_lists_url }
          format.json { head :no_content }
        end
      end

      def reset_all
        radio = RadioList.all
        radio.each do |r|
          if r.aasm_state == 'active'
            @mpd.stop
            @mpd.clear
          end
          r.clear_stream
        end
        respond_to do |format|
          format.html do
            redirect_to radio_lists_path,
                        notice: I18n.t('clear_message')
          end
        end
      end

      def play_stream
        return unless radio_params[:id]
        # old stream must be stopped first
        if session[:current_stream_id] == radio_params[:id].to_i
          @radio = RadioList.find(radio_params[:id])
          if @radio.sleeping?
            @radio.activate_stream
            @mpd.play
          end
        else
          if session[:current_stream_id]
            old_radio = RadioList.find(session[:current_stream_id])
            old_radio.clear_stream
          end
          @mpd.stop
          @mpd.clear
          @radio = RadioList.find(radio_params[:id])
          session['current_stream_id'] = @radio.id
          @radio.activate_stream
          @mpd.add(@radio.radio_url)
          @mpd.play
        end
        @volume = @mpd.volume
        @message = 'Playing ' + @radio.name
      end

      def stop_stream
        return unless radio_params[:id]
        @radio = RadioList.find(params[:id])
        @radio.stop_stream
        @mpd.stop
        @mpd.disconnect
        @message = 'Stopped  ' + @radio.name
        respond_to do |format|
          format.json do
            render json: { 'success' => true, 'message' => @message.to_s }
          end
        end
      end

      def play_again
        if session[:current_stream_id]
          @radio = RadioList.find(session[:current_stream_id])
          @radio.activate_stream
        end
        @mpd.play
        @mpd.disconnect
        respond_to do |format|
          format.json
        end
      end

      def volume_change
        @volume = @mpd.volume

        if radio_params
          if radio_params[:volValue]
            @volume += radio_params[:volValue].to_i
            @mpd.volume = @volume
          end
        end
        @message = 'Volume changed'
        respond_to do |format|
          format.json do
            render json: {
              'success' => true,
              'message' => @message.to_s,
              'volume' => I18n.t('volume_title', vol_val: @volume.to_s)
            }
          end
        end
      end

      private

      def find_active_stream
        active_radio = RadioList.find_active_radio.first
        current_stream_id = params[:current_stream_id]
        if active_radio
          if @current_stream_id != active_radio.id
            @current_stream_id = active_radio.id
          end
        else
          @current_stream_id = current_stream_id
        end
      end

      def radio_params
        params.fetch(:radio_list, {}).permit(
          :name,
          :description,
          :radio_url,
          :aasm_state
        )
      end

      def api_radio_params
        params.permit(:volValue, :id, :current_stream_id)
      end
    end
  end
end
