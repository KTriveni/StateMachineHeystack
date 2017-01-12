class AddParentNodeIdToStateMachineNode < ActiveRecord::Migration
  def change
  	add_column :state_machine_nodes, :parent_node_id, :string,array: true, default: []
  end
end
