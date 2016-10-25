class CreateRequestPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :request_posts do |t|
      t.string :title
      t.string :location
      t.date   :date
      t.text   :description
      t.timestamps
      t.integer :request_user_id
    end
  end
end
