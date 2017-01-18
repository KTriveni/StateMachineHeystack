module StateMachineNodesHelper
	def record_title(record)
		@user_journeys = []
		record.each do |journey|
			user_journey = []
			node_ids = journey
      node_ids.each do |node_id| 
	      user_journey << StateMachineNode.find_by(state_machine_id: params[:id],state_node_id: node_id.strip).node_title
      end
      @user_journeys <<  user_journey
		end
		return @user_journeys.uniq
	end

	def record_count(record)
		record_title(record).count
	end
end
