class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make methods available to views
  helper_method :current_user, :logged_in?

  private

  def current_user
    if user_id = session[:user_id]
      User.find_by(id: user_id)
    else
      nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in_user(user)
    session[:user_id] = user.id
  end

  def log_out_user(user)
    session[:user_id] = nil
  end
end
