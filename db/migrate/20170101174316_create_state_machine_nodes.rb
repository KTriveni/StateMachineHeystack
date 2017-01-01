class CreateStateMachineNodes < ActiveRecord::Migration
  def change
    create_table :state_machine_nodes do |t|
      t.string :node_title
      t.string :state_node_id
      t.string :state_machine_id
      t.timestamps null: false
    end
  end
end
