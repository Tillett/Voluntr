class Availability < ApplicationRecord
    for i in [:mon_st, :mon_en, :tues_st, :tues_en, 
              :wed_st, :wed_en, :thur_st, :thur_en,
              :fri_st, :fri_en, :sat_st, :sat_en, :sun_st, :sun_en]
                    validates i, :inclusion => {:in => [0,25]}
    end
    belongs_to :volunteer_user
end
