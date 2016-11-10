class UserScorecardsController < ApplicationController
    def new
        @user_scorecard = UserScorecard.new
    end
    
    def create
        @user_scorecard = UserScorecard.new(user_scorecard_params)
        
        ##call the review method in volunteer_users
        reviewee = VolunteerUser.find(@user_scorecard.volunteer_user_id)
        reviewee.review(@user_scorecard.skill_proficiency,
            @user_scorecard.attitude, @user_scorecard.enthusiasm,
            @user_scorecard.reliability)
    end
    
    private
    
        def user_scorecard_params
            params.require(:user_scorecard).permit(:volunteer_user_id, :skill_proficiency, :attitude,
                :enthusiasm, :reliability)
        end
end