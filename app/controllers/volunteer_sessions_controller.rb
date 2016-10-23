class VolunteerSessionsController < ApplicationController
  def new
  end
  
  def create
    volunteer_user = VolunteerUser.find_by(email: params[:session][:email].downcase)
    if volunteer_user && volunteer_user.authenticate(params[:session][:password])
      log_in volunteer_user
      params[:session][:remember_me] == '1' ? remember(volunteer_user) : forget(volunteer_user)
      redirect_to volunteer_user
    else
      flash.now[:danger] = 'Incorrect Account Information'
      render 'new'
    end
  end
  
  def destroy
    volunteer_user_log_out if volunteer_user_logged_in?
    redirect_to root_url
  end
end
