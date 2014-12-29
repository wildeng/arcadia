class RadioListsController < ApplicationController
  # GET /radio_lists
  # GET /radio_lists.json
 before_filter :start_connection
 after_filter  :stop_connection

  def index
    @radio_lists = RadioList.all
    active_radio = RadioList.find_active_radio.first
    if active_radio
      if session[:current_stream_id] != active_radio.id
        session[:current_stream_id] = active_radio.id
      end
    else
      session[:current_stream_id] = nil
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @radio_lists }
    end
  end

  # GET /radio_lists/1
  # GET /radio_lists/1.json
  def show
    @radio_list = RadioList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @radio_list }
    end
  end

  # GET /radio_lists/new
  # GET /radio_lists/new.json
  def new
    @radio_list = RadioList.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @radio_list }
    end
  end

  # GET /radio_lists/1/edit
  def edit
    @radio_list = RadioList.find(params[:id])
  end

  # POST /radio_lists
  # POST /radio_lists.json
  def create
    @radio_list = RadioList.new(params[:radio_list])

    respond_to do |format|
      if @radio_list.save
        format.html { redirect_to @radio_list, notice: 'Radio list was successfully created.' }
        format.json { render json: @radio_list, status: :created, location: @radio_list }
      else
        format.html { render action: "new" }
        format.json { render json: @radio_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /radio_lists/1
  # PUT /radio_lists/1.json
  def update
    @radio_list = RadioList.find(params[:id])

    respond_to do |format|
      if @radio_list.update_attributes(params[:radio_list])
        format.html { redirect_to @radio_list, notice: 'Radio list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @radio_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radio_lists/1
  # DELETE /radio_lists/1.json
  def destroy
    @radio_list = RadioList.find(params[:id])
    @radio_list.destroy

    respond_to do |format|
      format.html { redirect_to radio_lists_url }
      format.json { head :no_content }
    end
  end

  def play_stream
    if params[:id]
      #old stream must be stopped first
      if session[:current_stream_id] == params[:id].to_i
        @radio = RadioList.find(params[:id])
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
        @radio = RadioList.find(params[:id])
        session['current_stream_id'] = @radio.id
        @radio.activate_stream
        @mpd.add(@radio.radio_url)
        @mpd.play
      end
      @volume = @mpd.volume
      @message = 'Playing ' + @radio.name
    end
  end

  def stop_stream
    if params[:id]
      @radio = RadioList.find(params[:id])
      @radio.stop_stream
      @mpd.stop
      @mpd.disconnect
      @message = 'Stopped  ' + @radio.name
      respond_to do |format|
        format.html
        format.json
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

    if params
      if params[:volValue]
        @volume = @volume +  params[:volValue].to_i
        @mpd.volume = @volume
      end
    end
    @message = "Volume changed"
    respond_to do |format|
      format.json  { render json: {'success' => true, 'message' => @message.to_s, 'volume' => I18n.t('volume_title',:vol_val => @volume.to_s) }  }
    end
  end
  
end
