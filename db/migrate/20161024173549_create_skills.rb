class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.belongs_to :volunteer_user, index: true
      t.string :skill_name

      t.timestamps
    end
  end
end
