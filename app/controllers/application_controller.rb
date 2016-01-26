class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make methods available to views
  helper_method :current_user, :logged_in?

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    !@current_user.nil?
  end
end
