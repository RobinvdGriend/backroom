require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:user_1)
    @user.password = @user.password_confirmation = "password"
  end

  test "should log in user with valid login information" do
    post :create, email: @user.email,
                  password: @user.password,
                  password_confirmation: @user.password_confirmation

    # Check to see if we've been logged in
    assert session[:user_id] == @user.id
    assert_redirected_to user_path(@user)
  end 
end
