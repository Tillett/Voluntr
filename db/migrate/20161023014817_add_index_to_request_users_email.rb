class AddIndexToRequestUsersEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :request_users, :email, unique: true
  end
end
