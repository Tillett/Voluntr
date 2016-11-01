class RequestPostUpdatesController < ApplicationController
    def new
        @request_post_update = RequestPostUpdate.new
    end
    
    def create
        ##verifies correct user for this request_post_id!!!
        id = params[:request_post_update][:request_post_id]
        if (requester_has_post(id))
            @request_post_update = 
                            RequestPostUpdate.new(request_post_update_params)
            @request_post_update.request_post_id = id
            if @request_post_update.save
                redirect_to request_post_path(id)
            else
                redirect_to root_url
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
