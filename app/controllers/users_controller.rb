class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms.limit(30)
  end
  
  def new
    @user = User.new
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

  def edit
  end

  private

  def correct_user
    @user = User.find(params[:id])

    unless current_user == @user
      flash[:error] = "You can only edit your own profile"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
