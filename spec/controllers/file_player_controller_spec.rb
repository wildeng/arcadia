require "rails_helper"

RSpec.describe FilePlayerController, :type => :controller do
  describe "GET index" do
    it "renders index as success" do
      get :index
      expect(response.code.to_i).to eq(200)
    end
    
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "GET play files" do
    it "renders play_files as success" do
      get :play_files
      expect(response.code.to_i).to eq(200)
      
    end
    
    it "renders play_files template" do
      get :play_files
      expect(response).to render_template("play_files")
    end

  end

end