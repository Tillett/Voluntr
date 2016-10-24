class CreateVolunteerUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteer_users do |t|
      t.string  :display_name
      t.string  :email
      t.string  :password_digest
      t.text    :about_me
      t.string  :zip_code
      t.integer :points
      t.integer :rev_count
      t.boolean :no_search
    end
  end
end
