# creating radio list table
class CreateRadioLists < ActiveRecord::Migration
  def change
    create_table :radio_lists do |t|
      t.string :name
      t.text :description
      t.string :radio_url
      t.timestamps
    end
  end
end
