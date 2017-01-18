class StateMachineNodesController < ApplicationController
	include NodeSearch
	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

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
		if params[:file].nil?
			redirect_to :back, notice: 'Please upload csv file.'
		else	
	    StateMachineNode.import(params[:file].path,params[:state_machine_id])	
	    redirect_to :back, notice: 'Csv file uploaded sucessfully.'
	  end  
	end

	def node_import
    if params[:file].nil?
    	redirect_to :back, notice: 'Please upload csv file.'
		else	
	    StateMachineNodeResource.node_import(params[:file].path,params[:state_machine_id])	
	    redirect_to '/state_machines', notice: 'Csv file uploaded sucessfully.'
	  end
	end

	def show
		@state_machine_node = StateMachineNode.find_by(params[:node_id])
	end

  def destroy
  	@state_machine_node = StateMachineNode.find_by(id: params[:id])
    @state_machine_node.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'State machine node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check
    @graph = Hash.new { |hash, key| hash[key] = [] }
  end

  def addEdge(a, b)
    @graph[a] << b
    @graph[b] << a
  end


  def searchPath(a, b, result,lr)
    result = result+[a]
    lr << result if a == b
    @graph[a].each do |v|
         searchPath(v, b, result,lr) if ! result.include?(v)
    end
  end
	
	def generate_user_journey
		unless (params[:pick_up_node] || params[:exit_node]).blank?
			@state_machine_nodes = StateMachineNodeResource.where(state_machine_id: params['state_machine_id']).pluck(:parent_node_id,:child_node_id)
			node_stack = check
			@state_machine_nodes.each do |node_row| 
        addEdge(node_row[0],node_row[1])  
			end	
		  searchPath(params[:pick_up_node],params[:exit_node], [],a=[])
		  jing = []
			a.each do |qax|
			  wssd = []
			  qax.each_cons(2) {|gtd| wssd << gtd}
		    ting = []
		    wssd.each do |rswe|
		      if @state_machine_nodes.include? rswe
		        ting << 'true'
		      else 
		        ting << 'false'  
		      end
		    end
		    ysd = ting.uniq
		    if ((ysd.count == 1) && (ysd.include? 'true'))
		      jing << qax
		    end
			end
			@record = jing
      respond_to do |format|
		    format.js
		  end
		end 
	end

	def send_min_length(record,rl)
		min_path_size = rl.min
    record_index = rl.each_index.select{|i| rl[i] != min_path_size}
    return record.delete_if.with_index { |_, index| record_index.include? index }
	end
end
