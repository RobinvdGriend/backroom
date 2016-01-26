class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make methods available to views
  helper_method :logged_in_user

  def logged_in_user
    if user_id = session[:user_id]
      return @current_user = User.find_by(id: user_id)
    else
      return false
    end
  end
end
