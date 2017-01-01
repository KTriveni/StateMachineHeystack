class StateMachine < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "150x150>" , :original => "500x500>", :large => "800x800>" }
  do_not_validate_attachment_file_type :photo
end