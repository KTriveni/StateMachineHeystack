class StateMachineNodesController < ApplicationController
	def index
	  @state_machine = StateMachine.find_by(id: params['state_machine_id'])	
	  respond_to do |format|
	    format.html
	    format.csv do
	      headers['Content-Disposition'] = "attachment; filename=\"StateMachineNodeList\""
	      headers['Content-Type'] ||= 'text/csv'
	    end
	  end
	end

	def generate_nodes
		@state_machine_nodes = StateMachineNode.where(state_machine_id: params[:id].to_i)
	end

	def export
	  StateMachineNode.import(params[:file])	
	end

	def generate_user_journey
		unless (params[:pick_up_node] || params[:exit_node]).blank?
			@state_machine_nodes = StateMachineNode.where(state_machine_id: params['state_machine_id']) 
			if valid_nodes(@state_machine_nodes)
				generate_journey(params,@state_machine_nodes)
        @record = 'dsajjdh djshasd asgd ausygdyasdg ysuadg asyud asyudgsay dgsayd asyugdasygdsya dsayudg saydgasyudgasyud syuad '
			else	
			  @record = ''
      end
      respond_to do |format|
		    format.js
		  end
		end 
	end

	private
	def valid_nodes(state_machine_nodes)
		if @state_machine_nodes.collect(&:state_node_id).include? params[:pick_up_node]&&params[:exit_node]
      return true
    else
    	return false
		end	
	end

	def generate_journey(params,state_machine_nodes)
		pick_up_node = state_machine_nodes.find_by(state_node_id: params[:pick_up_node]) 
		exit_node = StateMachineNode.find_by(state_node_id: params[:exit_node])
	  user_journey1(pick_up_node,exit_node,state_machine_nodes)
	end

  def user_journey1(pick_up_node,exit_node,state_machine_nodes)
  	debugger
  end

	def user_journey(pick_up_node,exit_node,state_machine)
    journey = []
    journey << "#{exit_node.state_node_id} #{exit_node.node_title}"
    temp_journey = []
    temp_node = exit_node.parent_node_id
    unless temp_node.count == 0
	    temp_node.each do |t_p|
	    	d = StateMachineNode.find(state_machine_id: state_machine.id,state_node_id: t_p)
	    	temp_journey << "#{d.state_node_id} #{d.title}"
	    	break if d.state_node_id == exit_node
	    	unless d.parent_node_id.blank?
             
	    	end
			end		
    end
	end 
end
