class UsersController < ApplicationController
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
end
