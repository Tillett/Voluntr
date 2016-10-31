class VolunteerUsersController < ApplicationController
  
  def index
    #@volunteer_users = VolunteerUser.all
    @volunteer_users = VolunteerUser.search(params[:search])
  end
  
  def new
    @volunteer_user = VolunteerUser.new
  end
  
  def create
    @volunteer_user = VolunteerUser.new(volunteer_user_params)
    @volunteer_user.points = 0
    @volunteer_user.rev_count = 0
    if @volunteer_user.save
      volunteer_log_in @volunteer_user
      flash[:success] = "Log in successful"
      redirect_to @volunteer_user
    else
      flash.now[:danger] = "Please check the fields carefully"
      render 'new'
    end
  end
  
  def show
    @volunteer_user = VolunteerUser.find(params[:id])
  end
  
  private
  
    def volunteer_user_params
      params.require(:volunteer_user).permit(:email, :display_name, :zip_code,
      :about_me, :points, :rev_count, :no_search, :password, :password_confirmation)
    end
end
