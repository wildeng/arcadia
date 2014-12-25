class ApplicationController < ActionController::Base
  protect_from_forgery

  def start_connection
    @mpd = MPD.new APP_CONFIG['remote_server'], APP_CONFIG['remote_port']
    @mpd.connect
  end

  def stop_connection
    @mpd.disconnect
  end
end
