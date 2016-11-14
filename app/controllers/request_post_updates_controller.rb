class RequestPostUpdatesController < ApplicationController
    def new
        @request_post_update = RequestPostUpdate.new
    end
    
    def create
        id = params[:request_post_update][:request_post_id]
        if (requester_has_post(id))
            @request_post_update = 
                            RequestPostUpdate.new(request_post_update_params)
            @request_post_update.request_post_id = id
            if @request_post_update.save
                for job in RequestPost.find(id).request_post_jobs
                    if job.user_id != nil && (usr = VolunteerUser.find(job.user_id))
                        usr.notifications.create(title: "A job you're doing has been updated",
                        description: "#{@request_post_update.title.truncate(15)} .:. #{@request_post_update.text.truncate(15)} <%= link_to \"See it now!\", \"request_posts/#{id}\" %>")
                    end
                end
                redirect_to request_post_path(id)
            else
                flash[:danger] = "Nice try."
                redirect_to request_post_path(id)
            end
        end
    end
    
    
    def destroy
        #@request_post_update.destroy
        #redirect_to rp
        rpu = RequestPostUpdate.find(params[:id])
        rp = RequestPost.find(rpu.request_post_id)
        if (requester_has_post(rp.id))
            rpu.destroy
            redirect_to rp
        end
    end
    
    private
        def request_post_update_params
                  params.require(:request_post_update).permit(:title, :text, :request_post_id)
        end
end
