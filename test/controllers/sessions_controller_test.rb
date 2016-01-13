require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:user_1)
    @user.password = @user.password_confirmation = "password"
  end

  test "should log in user with valid login information" do
    post :create, email: @user.email,
                  password: @user.password

    # Check to see if we've been logged in
    assert session[:user_id] == @user.id
    assert_redirected_to user_path(@user)
  end 

  test "should not log in user with invalid login information" do
    post :create, email: "invalid",
                  password: "invalid"

    assert_nil session[:user_id]
    assert_template :new
  end

  test "should log out user" do
    delete :delete

    # Check to see if we've been logged out
    assert session[:user_id] == nil
    assert_redirected_to root_path
  end
end
