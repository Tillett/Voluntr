class CreateVolunteerUserSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteer_user_skills do |t|
      t.string :title
      t.references :volunteer_user, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
