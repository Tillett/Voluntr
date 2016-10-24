class CreateUserScorecards < ActiveRecord::Migration[5.0]
  def change
    create_table :user_scorecards do |t|
      t.integer :volunteer_user_id
      t.integer :skill_proficiency
      t.integer :attitude
      t.integer :enthusiasm
      t.integer :reliability

      t.timestamps
    end
  end
end
