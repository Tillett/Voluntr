module RequestSessionsHelper
  
  def log_in(request_user)
    session[:request_user_id] = request_user.id
  end
  
  def remember(request_user)
    request_user.remember
    cookies.permanent.signed[:request_user_id] = request_user.id
    cookies.permanent[:remember_token] = request_user.remember_token
  end
  
  def current_request_user
    if (request_user_id = session[:request_user_id])
      @current_request_user ||= RequestUser.find_by(id: session[:request_user_id])
    elsif (request_user_id = cookies.signed[:request_user_id])
      request_user = RequestUser.find_by(id: request_user_id)
      if request_user && request_user.authenticated?(cookies[:remember_token])
        log_in request_user
        @current_request_user = request_user
      end
    end
  end
  
  def request_user_logged_in?
    !current_request_user.nil?
  end
  
  def request_user_log_out
    session.delete(:request_user_id)
    @current_request_user = nil
  end
  
  def forget(request_user)
    request_user.forget
    cookies.delete(:request_user_id)
    cookies.delete(:remember_token)
    @current_request_user = nil
  end
end
