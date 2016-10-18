class CreateVolunteerUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteer_users do |t|

      t.timestamps
    end
  end
end
