class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
  end

  def create
    # TODO: Log in user upon succesful creation
    if user = User.create(user_params)
      flash[:succes] = "User has succesfully been created"
      redirect_to user_path(user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
