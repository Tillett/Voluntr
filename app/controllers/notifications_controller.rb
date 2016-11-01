class NotificationsController < ApplicationController
  def show
    if (usr = curr_any_user)
      @notifications = usr.notifications
    else
      redirect_to root_url
    end
  end
  
  ## Make sure correct user
  def destroy
    @notification = Notification.find_by(id: params[:id])
    if(curr_user_has_notification(@notification.id))
      @notification.destroy
    end
    redirect_to notification_url
  end
  
  private
    def notifications_params
      params.require(:notification).permit(:title, :description, :user)
    end
end
