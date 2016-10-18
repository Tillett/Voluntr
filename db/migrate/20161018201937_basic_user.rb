class BasicUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :type
      t.string :email
      t.string :password_digest
      t.string :display_name
      t.text   :about_me
    end
  end
end
