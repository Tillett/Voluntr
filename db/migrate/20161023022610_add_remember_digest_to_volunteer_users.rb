class AddRememberDigestToVolunteerUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :volunteer_users, :remember_digest, :string
  end
end
