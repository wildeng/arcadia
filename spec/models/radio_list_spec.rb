require "rails_helper"
require_relative "../../lib/personal/music_reader"

RSpec.describe RadioList, :type => :model do
    
  before(:each) do
    @bbc = RadioList.create(name: "BBC Radio 2", radio_url: "some url", description: "Best UK radio")
    @deejay = RadioList.create(name: "Deejay", radio_url: "some url", description: "Best IT radio")  
    @music_folder = "/Users/alainmauri/Music/iTunes/iTunes\ Media/Music/The\ Beatles/Love/"
  end
  it "order by name asc" do
    expect(RadioList.ordered_by_name).to eq([@bbc,@deejay])
  end
  
  it "find by state" do
    bbc = RadioList.create(name: "BBC Radio 2", radio_url: "some url", description: "Best UK radio", :aasm_state => 'sleeping')
    deejay = RadioList.create(name: "Deejay", radio_url: "some url", description: "Best IT radio", :aasm_state => 'active')
    expect(RadioList.find_active_radio).to eq([bbc,deejay])
  end
  
  it "idle a radio" do
    bbc = RadioList.create(name: "BBC Radio 2", radio_url: "some url", description: "Best UK radio", :aasm_state => 'active')
    bbc.stop_stream
    expect(RadioList.find_active_radio).not_to eq([])
  end
  
  it "should open a folder and read files" do
    music_reader = MusicReader.new
    files = music_reader.open_files(@music_folder)
    expect(files).not_to eq([])
  end
end