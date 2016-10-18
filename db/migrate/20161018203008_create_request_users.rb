class CreateRequestUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :request_users do |t|

      t.timestamps
    end
  end
end
