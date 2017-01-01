class StateMachineNodesController < ApplicationController
	def index
	  @state_machine = StateMachine.find_by(id: params['state_machine_id'])	
	end

	def generate_nodes
		@state_machine_nodes = StateMachineNode.where(state_machine_id: params[:id].to_i)
	end
end
