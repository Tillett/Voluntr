class CreateRequestPostJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :request_post_jobs do |t|
      t.belongs_to :request_post, index: true
      t.string :title
      t.text :description
      t.time :avail
      t.integer :user_id

      t.timestamps
    end
  end
end
