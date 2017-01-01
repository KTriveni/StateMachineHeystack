class AddAttachmentPhotoToStateMachines < ActiveRecord::Migration
  def self.up
    change_table :state_machines do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :state_machines, :photo
  end
end
