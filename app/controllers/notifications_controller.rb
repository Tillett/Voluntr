class NotificationsController < ApplicationController
  def show
  end
  
  ## Make sure correct user
  def destroy
    @notification = Notification.find_by(id: params[:id])
    @notification.destroy
    redirect_to notification_url
  end
  
  private
    def notifications_params
      params.require(:notification).permit(:title, :description, :user)  
    end
end
