class AddColumnAasmStateToRadioLists < ActiveRecord::Migration
  def change
    add_column :radio_lists, :aasm_state, :string, :default => :stopped
  end
end
