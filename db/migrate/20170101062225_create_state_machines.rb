class CreateStateMachines < ActiveRecord::Migration
  def change
    create_table :state_machines do |t|
      t.string :name
      t.string :node
      t.timestamps null: false
    end
  end
end
