class RadioList < ActiveRecord::Base
  attr_accessible :name, :description, :radio_url

  def check_link
  	return true
  end
end
