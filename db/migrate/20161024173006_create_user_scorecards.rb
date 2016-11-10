class CreateUserScorecards < ActiveRecord::Migration[5.0]
  def change
    create_table :user_scorecards do |t|
      t.integer :volunteer_user_id
      t.float :skill_proficiency
      t.float :attitude
      t.float :enthusiasm
      t.float :reliability

      t.timestamps
    end
  end
end
