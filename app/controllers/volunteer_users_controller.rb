class VolunteerUsersController < ApplicationController
  
  def index
    #@volunteer_users = VolunteerUser.all
    if (!current_request_user)
      redirect_to root_url
    end
    @volunteer_users = VolunteerUser.search(params[:search])
  end
  
  def new
    @volunteer_user = VolunteerUser.new
  end
  
  def create
    @volunteer_user = VolunteerUser.new(volunteer_user_params)
    ##Initialize Scorecard
    @volunteer_user.user_scorecard = UserScorecard.new
    @volunteer_user.build_user_scorecard( volunteer_user_id: @volunteer_user_id, 
                skill_proficiency: 0,attitude: 0,enthusiasm: 0, reliability: 0)
    @volunteer_user.points = 0
    @volunteer_user.rev_count = 0
    if @volunteer_user.save
      volunteer_log_in @volunteer_user
      flash[:success] = "Log in successful"
      @scorecard_id = @volunteer_user.user_scorecard.id
      redirect_to newavailability_path
    else
      flash.now[:danger] = "Please check the fields carefully"
      render 'new'
    end
  end
  
  def update
    @volunteer_user = VolunteerUser.find(params[:id])
    if @volunteer_user.update_attributes(volunteer_user_params)
      @volunteer_user = volunteer_user_params
      redirect_to @volunteer_user
    else
      render 'edit'
    end
  end
  
  def edit
    @volunteer_user = VolunteerUser.find(params[:id])
    if !users_id_is(@volunteer_user.id)
      redirect_to root_url
    end
  end
  
  def show
    @volunteer_user = VolunteerUser.find(params[:id])
  end
  
  def signal_interest()
    @volunteer_user = VolunteerUser.find(params[:id])
    ru = RequestUser.find(params[:rid]);
    if (requesters_id_is(ru.id))
      @volunteer_user.notifications
        .create(title: "#{ru.display_name} is interested in you!", 
        description: "<%= link_to \"See their page here!\", \"#{request_users_url}/#{params[:rid]}\" %>")
      flash[:success] = "This user has been notified!"
      redirect_to @volunteer_user
    end
  end
  
  
  private
  
    def volunteer_user_params
      params.require(:volunteer_user).permit(:email, :display_name, :zip_code,
      :about_me, :points, :rev_count, :no_search, :password, 
      :password_confirmation, :avatar, skill_ids: [])
    end
end
