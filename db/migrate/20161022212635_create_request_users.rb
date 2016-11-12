class CreateRequestUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :request_users do |t|
      t.string :email
      t.string :password_digest
      t.string :display_name
      t.string :tel_num
      t.string :fax_num
      t.string :website_address
      t.integer :rev_count
      t.text   :about_me
    end
  end
end
