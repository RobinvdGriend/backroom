module ApplicationHelper
  def logged_in_user
    if user_id = session[:user_id]
      return @current_user = User.find_by(id: user_id)
    else
      return false
    end
  end
end
