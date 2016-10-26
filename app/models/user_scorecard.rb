class UserScorecard < ApplicationRecord
    belongs_to :volunteer_user
    
    def new
        skill_proficiency = 0
        attitude = 0
        enthusiasm = 0
    end
end
