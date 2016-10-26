class RequestPostUpdatesController < ApplicationController
    def new
        @request_post_update = RequestPostUpdate.new
    end
    
    def create
        ##verifies correct user for this request_post_id!!!
        if ((cuser = current_request_user) != nil  &&
             (upd = cuser.request_posts.find(params[:request_post_update][:request_post_id])) != nil)
            @request_post_update = RequestPostUpdate.new(request_post_update_params)
            @request_post_update.request_post_id = params[:request_post_update][:request_post_id]
            if @request_post_update.save
                redirect_to upd
            else
                redirect_to root_url
            end
        end
    end
    
    
    def destroy
        @rpu = RequestPostUpdate.find(params[:id])
        if((cuser = current_request_user) != nil &&
            cuser.request_posts.find(@rpu.request_post_id) != nil)
            @rpu.destroy
        end
    end
    
    private
        def request_post_update_params
                  params.require(:request_post_update).permit(:title, :text, :request_post_id)
        end
end
