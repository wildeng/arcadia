class ApplicationController < ActionController::Base
  protect_from_forgery

  def start_connection
    begin
      @mpd = MPD.new APP_CONFIG['remote_server'], APP_CONFIG['remote_port']
      @mpd.connect
    rescue Errno::ETIMEDOUT
      logger.error('Server timeout')
      flash[:error] = I18n.t('server_timeout')
    end
  end

  def stop_connection
    @mpd.disconnect
  end
end
