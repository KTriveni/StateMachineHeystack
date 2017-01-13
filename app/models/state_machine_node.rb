class StateMachineNode < ActiveRecord::Base
  belongs_to :state_machine
  require 'csv'    
  def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv.add_row column_names
	    all.each do |foo|
	      values = foo.attributes.values
	      csv.add_row values
	    end
	  end
	end

	def self.import(file,state_machine_id)
		CSV.foreach(file, headers: true) do |row|
		  state_machine = StateMachineNode.new
		  state_machine.state_node_id = row.values_at[0]
		  state_machine.node_title = row.values_at[1]
		  state_machine.state_machine_id = state_machine_id
		  state_machine.parent_node_id << row.values_at[2]
		  state_machine.is_condition = row.values_at[3]
		  self.check_valid(state_machine)
		end
	end

	def self.check_valid(state_machine)
		init_node = StateMachineNode.find_by(state_machine_id: state_machine.state_machine_id,state_node_id: state_machine.state_node_id)
		if init_node.nil?
		  state_machine.save!
		end  
	end
end
