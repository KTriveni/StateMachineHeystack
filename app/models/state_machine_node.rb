class StateMachineNode < ActiveRecord::Base
  belongs_to :state_machine
  
  def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv.add_row column_names
	    all.each do |foo|
	      values = foo.attributes.values
	      csv.add_row values
	    end
	  end
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
	    StateMachineNode.create! row.to_hash
	  end
	end
end
