class AddColumnsToRadioLists < ActiveRecord::Migration
  def change
  	add_column :radio_lists, :name, :string
  	add_column :radio_lists, :description, :text
  	add_column :radio_lists, :radio_url, :string
  end
end
