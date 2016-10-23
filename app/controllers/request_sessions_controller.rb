class RequestSessionsController < ApplicationController
  def new
  end
  
  def create
    request_user = RequestUser.find_by(email: params[:session][:email].downcase)
    if request_user && request_user.authenticate(params[:session][:password])
      log_in request_user
      params[:session][:remember_me] == '1' ? remember(request_user) : forget(request_user)
      redirect_to request_user
    else
      flash.now[:danger] = 'Incorrect Account Information'
      render 'new'
    end
  end
  
  def destroy
    request_user_log_out if request_user_logged_in?
    redirect_to root_url
  end
end
