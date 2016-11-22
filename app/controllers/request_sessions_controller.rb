class RequestSessionsController < ApplicationController
  def new
  end
  
  def create
    #Find the request user in the database
    request_user = RequestUser.find_by(email: params[:session][:email].downcase)
    #If the request user logging in is found and their password digest matches, log them in
    #and redirect to their profile page
    if request_user && request_user.authenticate(params[:session][:password])
      request_log_in request_user
      params[:session][:remember_me] == '1' ? request_remember(request_user) : request_forget(request_user)
      redirect_to request_user
    else
    #If the log in is unsuccessful, diplay a warning and render the form again
      flash.now[:danger] = 'Incorrect Account Information'
      render 'new'
    end
  end
  
  def destroy
    #Destroy the session when the user logs out and redirect to home page
    request_user_log_out if request_user_logged_in?
    redirect_to root_url
  end
end