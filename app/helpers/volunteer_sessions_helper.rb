module VolunteerSessionsHelper

  def volunteer_log_in(volunteer_user)
    #clear_logins
    session[:volunteer_user_id] = volunteer_user.id
  end
  
  def volunteer_remember(volunteer_user)
    volunteer_user.volunteer_remember
    cookies.permanent.signed[:volunteer_user_id] = volunteer_user.id
    cookies.permanent[:remember_token] = volunteer_user.remember_token
  end
  
  def current_volunteer_user
    if (volunteer_user_id = session[:volunteer_user_id])
      @current_volunteer_user ||= VolunteerUser.find_by(id: session[:volunteer_user_id])
    elsif (volunteer_user_id = cookies.signed[:volunteer_user_id])
      volunteer_user = VolunteerUser.find_by(id: volunteer_user_id)
      if volunteer_user && volunteer_user.authenticated?(cookies[:remember_token])
        log_in volunteer_user
        @current_volunteer_user = volunteer_user
      end
    end
  end
  
  def volunteer_user_logged_in?
    !current_volunteer_user.nil?
  end
  
  def volunteer_user_log_out
    session.delete(:volunteer_user_id)
    @current_volunteer_user = nil
  end
  
  def volunteer_forget(volunteer_user)
    volunteer_user.forget
    cookies.delete(:volunteer_user_id)
    cookies.delete(:remember_token)
    @current_volunteer_user = nil
  end
end
