class UserScorecard < ApplicationRecord
    belongs_to :volunteer_user
    
    def new
    end
end
