class AddRememberDigestToRequestUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :request_users, :remember_digest, :string
  end
end
