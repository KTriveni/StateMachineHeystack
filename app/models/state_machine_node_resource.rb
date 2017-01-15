class StateMachineNodeResource < ActiveRecord::Base
  belongs_to :state_machine
  belongs_to :state_machine_node

  def self.node_import(file,state_machine_id)
		CSV.foreach(file, headers: true) do |row|
		  state_machine_node = StateMachineNodeResource.new
		  state_machine_node.parent_node_id = row.values_at[0]
		  state_machine_node.child_node_id = row.values_at[1]
		  state_machine_node.state_machine_id = state_machine_id
		  self.check_valid(state_machine_node)
		end
	end

	def self.check_valid(state_machine_node)
		init_node = StateMachineNodeResource.where(state_machine_id: state_machine_node.state_machine_id,parent_node_id: state_machine_node.parent_node_id,child_node_id: state_machine_node.child_node_id)
		if init_node.blank?
		  state_machine_node.save!
		end  
	end
end
