class AddAttachmentAvatarToVolunteerUsers < ActiveRecord::Migration
  def self.up
    change_table :volunteer_users do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :volunteer_users, :avatar
  end
end
