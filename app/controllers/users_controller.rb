class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
  end

  def create
    # TODO: Log in user upon succesful creation
    @user = User.new(user_params)

    if @user.save
      flash[:succes] = "User has succesfully been created"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
