class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, polymorphic: true, index: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
