require 'rails_helper'

RSpec.describe "file_player/play_files", :type => :view do
  it "displays an input file field" do
    render
    expect(view).to render_template('play_files')
  end
end