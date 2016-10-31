class NotificationsController < ApplicationController
  def show
  end
  
  ## Make sure correct user
  def destroy
    @notification = Notification.find_by(id: params[:id])
    if((cuser = current_request_user || current_volunteer_user) != nil && 
        cuser.class.name == @notification.user_type &&
        cuser.id == @notification.user_id)
      @notification.destroy
    end
    redirect_to notification_url
  end
  
  private
    def notifications_params
      params.require(:notification).permit(:title, :description, :user)
    end
end
