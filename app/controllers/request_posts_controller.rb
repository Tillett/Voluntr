class RequestPostsController < ApplicationController
  def new
    @request_post = RequestPost.new
  end
  
  def index
    #@request_posts = RequestPost.all
    @request_posts = RequestPost.search(params[:search])
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
    @request_post_update = RequestPostUpdate.new
    @request_post = RequestPost.find(params[:id])
  end

  def destroy
    @request_post = RequestPost.find(params[:id])
    if(requester_has_post(@request_post.id))
      @request_post.destroy
      redirect_to root_url
    end
  end
  
  private
    
    def request_post_params
      params.require(:request_post).permit(:title, :location, :date, :description,
          :request_user_id)
    end
end
