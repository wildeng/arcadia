# Main controller for playing and defining new streams
# @author Alain Mauri
# @version 0.1
class FilePlayerController < ApplicationController
  before_filter :start_connection
  after_filter  :stop_connection

  def index
    respond_to do |format|
      format.html
    end
  end

  def play_files
    respond_to do |format|
      format.html
    end
  end
end
