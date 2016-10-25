class VolunteerUsersController < ApplicationController
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
