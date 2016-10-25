class RequestUsersController < ApplicationController
  def new
    @request_user = RequestUser.new
  end
  
  def create 
    @request_user = RequestUser.new(request_user_params)
    if @request_user.save
      request_log_in @request_user
      flash[:success] = "Log in successful"
      redirect_to @request_user
    else
      render 'new'
    end
  end
  
  def show
    @request_user = RequestUser.find(params[:id])
  end
  
  private
    def request_user_params
      params.require(:request_user).permit(:email, :display_name, :tel_num,
        :fax_num, :website_address, :about_me, :password, :password_confirmation)
    end
end
