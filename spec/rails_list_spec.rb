require 'spec_helper'

describe RadioList do 
	before :each do
		@radio = RadioList.new 
		@radio.name = "Deejay"
		@radio.description = "Radio for a test"
		@radio.url = "http://mp3.kataweb.it:8000/RadioDeejay"
	end
end

