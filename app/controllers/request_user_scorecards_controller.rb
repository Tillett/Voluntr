class RequestUserScorecardsController < ApplicationController
    def new
        @request_user_scorecard = RequestUserScorecard.new
    end
    
    def create
    end
    
    def edit
        @request_user_scorecard = RequestUserScorecard.find_by(request_user_id: params[:request_user_scorecard][:request_user_id])
    end
    
    def verify_scores
        #check for skill proficiency verification
        if @new_lead > 100 || @new_lead < 0
            flash[:danger] = "Review Failed: Scores must be from 0 to 100"
            return false
            
            #check for attitude verification
            elsif @new_treat > 100 || @new_treat < 0
                flash[:danger] = "Review Failed: Scores must be from 0 to 100"
                return false
                
                #check for enthusiasm verification
                elsif @new_commit > 100 || @new_commit < 0
                    flash[:danger] = "Review Failed: Scores must be from 0 to 100"
                    return false
                    
                        else
                            #all verifications succeeded
                            flash[:success] = "Review Succeeded"
                            return true
        end
    end
    
    def verify_user
        #if job.id = the id
        return true
    end
    
    def verify_reviewable
        #check that reviewed flag is false
    end
    
    def update
        #Find the request user scorecard in the database
        @request_user_scorecard = RequestUserScorecard.find_by(request_user_id: params[:request_user_scorecard][:request_user_id])
        #Find the request user associated with the scorecard in the database
        @req_user = RequestUser.find_by(id: params[:request_user_scorecard][:request_user_id])
        
        #load in scores to prepare for verification
        @new_lead = params[:request_user_scorecard][:leadership].to_f
        @new_treat = params[:request_user_scorecard][:treatment].to_f
        @new_commit = params[:request_user_scorecard][:committedness].to_f
        
        #A comment
        @job = RequestPostJob.find(params[:rpjid])
        
        #make sure the scores are correct
        if verify_scores and verify_user
            
            #Average old scored with new scores
            @old_review_count = @req_user.rev_count.to_f
            @lead = ((@new_lead.to_f + (@request_user_scorecard.leadership.to_f * @old_review_count.to_f)) / ((@old_review_count + 1.0).to_f))
            @treat = ((@new_treat + (@request_user_scorecard.treatment * @old_review_count)) / (@old_review_count + 1))
            @commit = ((@new_commit + (@request_user_scorecard.committedness * @old_review_count)) / (@old_review_count + 1))
            
            #Update user scorecard in the database
            @request_user_scorecard.update_attribute(:leadership, @lead)
            @request_user_scorecard.update_attribute(:treatment, @treat)
            @request_user_scorecard.update_attribute(:committedness, @commit)
            
            #Update review count
            @review_count = 1.0 + @req_user.rev_count.to_f
            @req_user.update_attribute(:rev_count, @review_count)
            
            #Set the job volunteer flag as reviewed
            @job.update_attribute(:request_reviewed, true)
            
            #Redirect to user's profile
            redirect_to @req_user
        else
            redirect_to @req_user
        end
    end
    
    def show
        @request_user_scorecard = RequestUserScorecard.find(params[:id])
    end
    
    private
    
        def request_user_scorecard_params
            params.require(:request_user_scorecard).permit(:request_user_id, :leadership,
                :treatment, :committedness)
        end
end