# skeleton class to play music files in a folder
# this is WIP
class MusicReader
  require 'pp'

  def open_files(folder)
    files = []
    Dir.foreach(folder) do |fname|
      next if ['.', '..'].include?(fname)
      files.push(fname)
    end
    files
  end
end
