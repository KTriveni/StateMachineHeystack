class AddConditionTostatemaachineNode < ActiveRecord::Migration
  def change
  	add_column :state_machine_nodes, :is_condition, :boolean ,default: false
  end
end
