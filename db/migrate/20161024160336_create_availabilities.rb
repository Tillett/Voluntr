class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.integer :volunteer_user_id
      t.integer :mon_st
      t.integer :mon_en
      t.integer :tues_st
      t.integer :tues_en
      t.integer :wed_st
      t.integer :wed_en
      t.integer :thur_st
      t.integer :thur_en
      t.integer :fri_st
      t.integer :fri_en
      t.integer :sat_st
      t.integer :sat_en
      t.integer :sun_st
      t.integer :sun_en

      t.timestamps
    end
  end
end
