class AddIndexToVolunteerUsersEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :volunteer_users, :email, unique: true
  end
end
