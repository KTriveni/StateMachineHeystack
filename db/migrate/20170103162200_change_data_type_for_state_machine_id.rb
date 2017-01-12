class ChangeDataTypeForStateMachineId < ActiveRecord::Migration
  def self.up
    change_table :state_machine_nodes do |t|
      t.change :state_machine_id, :string
    end
  end
  def self.down
    change_table :state_machine_nodes do |t|
      t.change :state_machine_id, :integer
    end
  end
end
