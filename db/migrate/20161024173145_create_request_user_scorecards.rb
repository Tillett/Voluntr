class CreateRequestUserScorecards < ActiveRecord::Migration[5.0]
  def change
    create_table :request_user_scorecards do |t|
      t.integer :request_user_id
      t.integer :leadership
      t.integer :treatment
      t.integer :committedness

      t.timestamps
    end
  end
end
