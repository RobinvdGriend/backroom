module SessionsHelper
  def log_in_user(user)
    session[:user_id] = user.id
  end

  def log_out_user(user)
    session[:user_id] = nil
  end
end
