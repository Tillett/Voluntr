class AddAttachmentLogoToRequestUsers < ActiveRecord::Migration
  def self.up
    change_table :request_users do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :request_users, :logo
  end
end
