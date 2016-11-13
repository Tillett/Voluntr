class AddRevCountToRequestUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :request_users, :rev_count, :integer
  end
end
