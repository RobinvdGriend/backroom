class SessionsController < ApplicationController
  # TODO: Add tests

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    
    if @user &&  @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Wrong login information"
      render :new
    end
  end

  def delete
  end
end
