class RequestUsersController < ApplicationController
  def new
    @request_user = RequestUser.new
  end
  
  def index
    #@request_users = RequestUser.all
    @request_users = RequestUser.search(params[:search])
  end
  
  def create 
    @request_user = RequestUser.new(request_user_params)
    ##Initialize Scorecard
    @request_user.request_user_scorecard = RequestUserScorecard.new
    @request_user.build_request_user_scorecard( request_user_id: @request_user_id, 
                leadership: 0,treatment: 0,committedness: 0)
    @request_user.rev_count = 0
    if @request_user.save
      request_log_in @request_user
      flash[:success] = "Log in successful"
      redirect_to @request_user
    else
      render 'new'
    end
  end
  
  def update
    @request_user = RequestUser.find(params[:id])
    if @request_user.update_attributes(request_user_params)
      @request_user = request_user_params
      redirect_to @request_user
    else
      render 'edit'
    end
  end

  def edit
    @request_user = RequestUser.find(params[:id])
    if !requesters_id_is(@request_user.id)
      redirect_to root_url
    end
  end
  
  def show
    @request_user = RequestUser.find(params[:id])
  end
  
  private
    def request_user_params
      params.require(:request_user).permit(:email, :display_name, :tel_num,
        :fax_num, :website_address, :about_me, :password, :password_confirmation, :logo)
    end
    
    
end