class NotificationsController < ApplicationController
  def show
  end
  
  ##JUST FOR TESTING! FIXME!
  def destroy(i)
    i.destroy
    flash.now[:success] = "Message deleted!"
    redirect_to home_path
  end
end
