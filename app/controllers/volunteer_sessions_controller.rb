class VolunteerSessionsController < ApplicationController
  def new
  end
  
  def create
    clear_logins
    #Find the volunteer user in the database
    volunteer_user = VolunteerUser.find_by(email: params[:session][:email].downcase)
    #If the volunteer user logging in is found and their password digest matches,
    #log them in and redirect to their profile page
    if volunteer_user && volunteer_user.authenticate(params[:session][:password])
      volunteer_log_in volunteer_user
      params[:session][:remember_me] == '1' ? volunteer_remember(volunteer_user) : volunteer_forget(volunteer_user)
      redirect_to volunteer_user
    else
      #If the log in is unsuccessful, display a warning and render the form again
      flash.now[:danger] = 'Incorrect Account Information'
      render 'new'
    end
  end
  
  def destroy
    #Destroy the session when the user logs out and redirect to home page
    volunteer_user_log_out if volunteer_user_logged_in?
    redirect_to root_url
  end
end