class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include RequestSessionsHelper
  include VolunteerSessionsHelper
  
  helper_method :curr_any_user
  def curr_any_user
    return current_request_user || current_volunteer_user
  end
  
  helper_method :requesters_id_is
  def requesters_id_is(id)
    return ((usr = current_request_user) && usr.id == id)
  end
  
  helper_method :users_id_is
  def user_id_is(id)
    return ((usr = current_volunteer_user) && usr.id == id)
  end
  
  helper_method :curr_user_has_notification
  def curr_user_has_notification(id)
    cuser = current_request_user || current_volunteer_user
    if (cuser != nil)
        return (cuser.notifications.find(id) != nil)
    end
    false
  end
  
  helper_method :requester_has_post
  def requester_has_post(id)
    cuser = current_request_user
    if(cuser != nil)
      return cuser.request_posts.find(id) != nil
    end
    false
  end
end
