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
    
    ##Initialize Review Flags
    @request_post_job.volunteer_reviewed = false
    @request_post_job.request_reviewed = false
    
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
  
  def assoc_with_user()
    @request_post_job = RequestPostJob.find(params[:id])
    if(requester_has_post(@request_post_job.request_post_id))
        if params[:vid] != "nil"
          @request_post_job.update_attribute(:user_id, params[:vid])
        else
          @request_post_job.update_attribute(:user_id, nil)
        end
        redirect_to "/request_posts/#{@request_post_job.request_post_id}"
    elsif (@request_post_job.user_id != nil && users_id_is(@request_post_job.user_id))
        @request_post_job.update_attribute(:user_id, nil)
        redirect_to "/request_posts/#{@request_post_job.request_post_id}"
    end
  end
  
  def user_sig_interest()
    @request_post_job = RequestPostJob.find(params[:id])
    vol = VolunteerUser.find(params[:vid])
    req_post = RequestPost.find(@request_post_job.request_post_id)
    req = RequestUser.find(req_post.request_user_id)
    if(users_id_is(vol.id))
      req.notifications.create(title: "A user has signalled interest in a job!",
      description: "<%= link_to \"<#{vol.display_name}>\", \"volunteer_users/#{vol.id}\" %>"\
                   " is interested in your job, #{@request_post_job.title.truncate(25)} --"\
                   " #{@request_post_job.description.truncate(25)}. "\
                   " You may <%= link_to \"<approve them>\", {:controller => "\
                   ":request_post_jobs, :action => :assoc_with_user, "\
                   "id: \"#{params[:id]}\", vid: \"#{vol.id}\"}, method: :post %> now")
      redirect_to req_post
    end
  end
  
  private
    
    def request_post_job_params
      params.require(:request_post_job).permit(:title, :avail, :description)
    end
end
