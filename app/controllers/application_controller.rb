# Base class for controllers
# @author Alain Mauri
# @version 0.1
class ApplicationController < ActionController::Base
  protect_from_forgery

  def start_connection
    @mpd = MPD.new APP_CONFIG['remote_server'], APP_CONFIG['remote_port']
    @mpd.connect
  rescue Errno::ETIMEDOUT
    logger.error('Server timeout')
    flash[:error] = I18n.t('server_timeout')
  end

  def stop_connection
    @mpd.disconnect
  end
end
