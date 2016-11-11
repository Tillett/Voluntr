class RequestPostJobsController < ApplicationController
  def new
    @request_post_job = RequestPostJob.new
  end

  def create
    puts "LOOK AT ME RIGHT HERE"
    puts params[:id]
    puts "---------------------------"
    @request_post_job = RequestPostJob.new(request_post_job_params)
    @request_post = RequestPost.find(params[:id])

    if !requester_has_post(@request_post.id)
      redirect_to root_url
    end
    
    @request_post_job.request_post_id = @request_post.id
    
    if @request_post_job.save
      flash[:success] = "Request Post Job Created"
      redirect_to @request_post
    else
      flash.now[:danger] = 'Unsuccessful'
      render 'new'
    end
  end

  def destroy
    @request_post_job = RequestPostJob.find(params[:id])
    if(requester_has_post(@request_post.id))
      @request_post.destroy
      redirect_to root_url
    end
  end
  
  def assocwithuser(id)
    
  end
  
  private
    
    def request_post_job_params
      params.require(:request_post_job).permit(:title, :avail, :description)
    end
end
