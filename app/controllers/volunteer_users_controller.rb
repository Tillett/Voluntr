class VolunteerUsersController < ApplicationController
  
  def index
    #Redirect to home page if a volunteer user is not logged in
    if (!current_volunteer_user)
      redirect_to root_url
    end
    
    #Search database for volunteer user matching search param
    @volunteer_users = VolunteerUser.search(params[:search])
  end
  
  def new
    #Create a new volunteer user record
    @volunteer_user = VolunteerUser.new
  end
  
  def create
    #Create a volunteer user with the passed params
    @volunteer_user = VolunteerUser.new(volunteer_user_params)
    #Create an empty scorecard for the volunteer user
    @volunteer_user.user_scorecard = UserScorecard.new
    @volunteer_user.build_user_scorecard(volunteer_user_id: @volunteer_user_id, 
                skill_proficiency: 0,attitude: 0,enthusiasm: 0, reliability: 0)
    @volunteer_user.build_availability(volunteer_user_id: @volunteer_user_id)
    #Initialize variables
    @volunteer_user.points = 0
    @volunteer_user.rev_count = 0
    #Attempt to save the volunteer user to the database and redirect to their availability page
    if @volunteer_user.save
      volunteer_log_in @volunteer_user
      flash[:success] = "Log in successful"
      @scorecard_id = @volunteer_user.user_scorecard.id
      redirect_to edit_availability_path
    #If save is unsuccessful, display warning and render form again
    else
      flash.now[:danger] = "Please check the fields carefully"
      render 'new'
    end
  end
  
  def update
    #Find the volunteer user in the database
    @volunteer_user = VolunteerUser.find(params[:id])
    #Try to save the changed profile information and redirect to the user's profile page
    if @volunteer_user.update_attributes(volunteer_user_params)
      @volunteer_user = volunteer_user_params
      redirect_to @volunteer_user
    #If the save is unsuccessful, display warning and render form again
    else
      flash.now[:danger] = "Please check the fields carefully"
      render 'edit'
    end
  end
  
  def edit
    #Find the volunteer user in the database
    @volunteer_user = VolunteerUser.find(params[:id])
    #If a user is not logged in with the id of the user they're trying to edit, redirect to home page
    if !users_id_is(@volunteer_user.id)
      redirect_to root_url
    end
  end
  
  def show
    #Find the volunteer user in the database
    @volunteer_user = VolunteerUser.find(params[:id])
  end
  
  def signal_interest()
    @volunteer_user = VolunteerUser.find(params[:id])
    ru = RequestUser.find(params[:rid])
    if (requesters_id_is(ru.id))
      @volunteer_user.notifications
        .create(title: "#{ru.display_name} is interested in you!", 
        description: "<%= link_to \"See their page here!\", \"#{request_users_url}/#{params[:rid]}\" %>")
      flash[:success] = "This user has been notified!"
      redirect_to @volunteer_user
    end
  end
  
  def following
    if (!current_volunteer_user)
      redirect_to root_url
    end
    @volunteer_user = current_volunteer_user
  end
  
  private
  
    def volunteer_user_params
      #Parameter validation
      params.require(:volunteer_user).permit(:email, :request_post_job_id, :display_name, :zip_code,
                                             :about_me, :points, :rev_count, :no_search, :password, 
                                             :password_confirmation, :avatar, skill_ids: [])
    end
end
