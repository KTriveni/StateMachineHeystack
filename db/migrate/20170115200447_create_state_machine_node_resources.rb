class CreateStateMachineNodeResources < ActiveRecord::Migration
  def change
    create_table :state_machine_node_resources do |t|
      t.string :parent_node_id
      t.string :child_node_id
      t.integer :state_machine_id 
      t.timestamps null: false
    end
  end
end
