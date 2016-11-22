class UserScorecardsController < ApplicationController
    def new
        @user_scorecard = UserScorecard.new
    end
    
    def create
    end
    
    def verify_scores
        #check for skill proficiency verification
        if @new_skill_prof > 100 || @new_skill_prof < 0
            flash[:danger] = "Review Failed: Scores must be from 0 to 100"
            return false
            
            #check for attitude verification
            elsif @new_attit > 100 || @new_attit < 0
                flash[:danger] = "Review Failed: Scores must be from 0 to 100"
                return false
                
                #check for enthusiasm verification
                elsif @new_enth > 100 || @new_enth < 0
                    flash[:danger] = "Review Failed: Scores must be from 0 to 100"
                    return false
                    
                    #check for reliability verification
                    elsif @new_reliab > 100 || @new_reliab < 0
                        flash[:danger] = "Review Failed: Scores must be from 0 to 100"
                        return false
                        
                        else
                            #all verifications succeeded
                            flash[:success] = "Review Succeeded"
                            return true
        end
    end
    
    def update
        #Find the user scorecard in the database
        @user_scorecard = UserScorecard.find_by(volunteer_user_id: params[:user_scorecard][:volunteer_user_id])
        #Find the volunteer user associated with the scorecard in the database
        @vol_user = VolunteerUser.find_by(id: params[:user_scorecard][:volunteer_user_id])
        
        #load in scores to prepare for verification
        @new_skill_prof = params[:user_scorecard][:skill_proficiency].to_f
        @new_attit = params[:user_scorecard][:attitude].to_f
        @new_enth = params[:user_scorecard][:enthusiasm].to_f
        @new_reliab = params[:user_scorecard][:reliability].to_f
        
        #make sure the scores are correct
        if verify_scores
            
            #Average old scores with new scores
            @old_review_count = @vol_user.rev_count.to_f
            @skill_prof = ((@new_skill_prof.to_f + (@user_scorecard.skill_proficiency.to_f * @old_review_count.to_f)) / ((@old_review_count + 1.0).to_f))
            @attit = ((@new_attit + (@user_scorecard.attitude * @old_review_count)) / (@old_review_count + 1))
            @enth = ((@new_enth + (@user_scorecard.enthusiasm * @old_review_count)) / (@old_review_count + 1))
            @reliab = ((@new_reliab + (@user_scorecard.reliability * @old_review_count)) / (@old_review_count + 1))
            
            #Update user scorecard in the database
            @user_scorecard.update_attribute(:skill_proficiency, @skill_prof)
            @user_scorecard.update_attribute(:attitude, @attit)
            @user_scorecard.update_attribute(:enthusiasm, @enth)
            @user_scorecard.update_attribute(:reliability, @reliab)
            
            #Update review count and points
            @review_count = 1.0 + @vol_user.rev_count.to_f
            @vol_user.update_attribute(:rev_count, @review_count)
            @points = @vol_user.points.to_f
            @add_points = 5.0 * (@new_skill_prof + @new_attit + @new_reliab + @new_enth)
            @points = @points + @add_points
            @vol_user.update_attribute(:points, @points)
            
            #Set the review flag
            @job = RequestPostJob.find(params[:rpjid])
            @job.update_attribute(:volunteer_reviewed, true)
            
            #Redirect to user's profile
            redirect_to @vol_user
        else
            redirect_to @vol_user
        end
    end
    
    def show
        #Find user's scorecard
        @user_scorecard = UserScorecard.find(params[:id])
    end
    
    private
    
        def user_scorecard_params
            #Parameter validation
            params.require(:user_scorecard).permit(:volunteer_user_id, :request_post_job_id, :skill_proficiency, :attitude,
                :enthusiasm, :reliability)
        end
end