# adding columns to radio list table
class AddColumnsToRadioLists < ActiveRecord::Migration
  def change
    change_column :radio_lists, :name, :string
    change_column :radio_lists, :description, :text
    change_column :radio_lists, :radio_url, :string
  end
end
