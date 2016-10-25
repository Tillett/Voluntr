class RequestPostsController < ApplicationController
  def new
    @request_post = RequestPost.new
  end

  def create
    @request_post = RequestPost.new(request_post_params)
    @request_post.request_user_id = session[:request_user_id]
    if @request_post.save
      
      # for user in VolunteerUsers.where(x => x.follows.contains(request_user_id))
      #  user.notifications.create(title: "Someone you follow has a new opportunity!", description: "whatever")
      
      flash[:success] = "Request Post Created"
      redirect_to @request_post
    else
      flash.now[:danger] = 'Unsuccessful'
      render 'new'
    end
  end

  def show
    @request_post = RequestPost.find(params[:id])
  end

  def destroy
  end
  
  private
    
    def request_post_params
      params.require(:request_post).permit(:title, :location, :date, :description,
          :request_user_id)
    end
end
