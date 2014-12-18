class RadioListsController < ApplicationController
  # GET /radio_lists
  # GET /radio_lists.json


  def index
    @radio_lists = RadioList.all

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
      @radio = RadioList.find(params[:id])
      mpd = MPD.new '192.168.0.2', 6600
      mpd.connect
      mpd.add(@radio.radio_url)
      mpd.play
      @message = 'Playing ' + @radio.name
      mpd.disconnect
    end
  end

  def stop_stream
    if params[:id]
      @radio = RadioList.find(params[:id])
      mpd = MPD.new '192.168.0.2', 6600
      mpd.connect
      mpd.stop
      mpd.clear
      mpd.disconnect
      @message = 'Stopped  ' + @radio.name
      respond_to do |format|
        format.html
      end
    end
  end

  def volume_change
    mpd = MPD.new '192.168.0.2', 6600
    mpd.connect
    if params
      if params[:volValue]
        #TODO implement volume changes
      end
    end
    mpd.disconnect
    @message = "Volume changed"
    respond_to do |format|
      format.json  { render json: {'success' => true, 'message' => @message.to_s }  }

    end
  end
  
end
