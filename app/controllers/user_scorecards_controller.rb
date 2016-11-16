class UserScorecardsController < ApplicationController
    def new
        @user_scorecard = UserScorecard.new
    end
    
    def create
    end
    
    def update
        @user_scorecard = UserScorecard.find_by(volunteer_user_id: params[:user_scorecard][:volunteer_user_id])
        @vol_user = VolunteerUser.find_by(id: params[:user_scorecard][:volunteer_user_id])
        @old_reviews = 0
        @old_review_count = @vol_user.rev_count.to_f
        @new_skill_prof = params[:user_scorecard][:skill_proficiency].to_f
        @skill_prof = ((@new_skill_prof.to_f + (@user_scorecard.skill_proficiency.to_f * @old_review_count.to_f)) / ((@old_review_count + 1.0).to_f))
        @new_attit = params[:user_scorecard][:attitude].to_f
        @attit = ((@new_attit + (@user_scorecard.attitude * @old_review_count)) / (@old_review_count + 1))
        @new_enth = params[:user_scorecard][:enthusiasm].to_f
        @enth = ((@new_enth + (@user_scorecard.enthusiasm * @old_review_count)) / (@old_review_count + 1))
        @new_reliab = params[:user_scorecard][:reliability].to_f
        @reliab = ((@new_reliab + (@user_scorecard.reliability * @old_review_count)) / (@old_review_count + 1))
        @user_scorecard.update_attribute(:skill_proficiency, @skill_prof)
        @user_scorecard.update_attribute(:attitude, @attit)
        @user_scorecard.update_attribute(:enthusiasm, @enth)
        @user_scorecard.update_attribute(:reliability, @reliab)
        redirect_to current_request_user
        @review_count = 1.0 + @vol_user.rev_count.to_f
        @vol_user.update_attribute(:rev_count, @review_count)
        @points = @vol_user.points.to_f
        @add_points = 5.0 * (@new_skill_prof + @new_attit + @new_reliab + @new_enth)
        @points = @points + @add_points
        @vol_user.update_attribute(:points, @points)
    
        @job = RequestPostJob.find(params[:request_user_scorecard][:rpjid])
        @job.update_attribute(:volunteer_reviewed, true)
        redirect_to @vol_user
    end
    
    def show
        @user_scorecard = UserScorecard.find(params[:id])
    end
    
    private
    
        def user_scorecard_params
            params.require(:user_scorecard).permit(:volunteer_user_id, :request_post_job_id, :skill_proficiency, :attitude,
                :enthusiasm, :reliability)
        end
end