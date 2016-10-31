class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.integer :volunteer_user_id
      t.time :mon_st
      t.time :mon_en
      t.time :tues_st
      t.time :tues_en
      t.time :wed_st
      t.time :wed_en
      t.time :thur_st
      t.time :thur_en
      t.time :fri_st
      t.time :fri_en
      t.time :sat_st
      t.time :sat_en
      t.time :sun_st
      t.time :sun_en

      t.timestamps
    end
    add_index :availabilities, :volunteer_user_id, unique: true
  end
end
