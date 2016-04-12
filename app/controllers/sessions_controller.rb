class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user &&  user.authenticate(params[:password])
      log_in_user(user)
      redirect_to user_path(user)
    else
      flash[:error] = "Wrong login information"
      render :new
    end
  end

  def delete
    if logged_in?
      log_out_user(current_user)
      flash[:notice] = "You have been logged out"
      redirect_to root_path
    else
      flash[:notice] = "You have already been logged out"
      redirect_to root_path
    end
  end
end
