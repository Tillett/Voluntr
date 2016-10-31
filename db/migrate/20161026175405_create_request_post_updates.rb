class CreateRequestPostUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :request_post_updates do |t|
      t.belongs_to :request_post, index: true
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
