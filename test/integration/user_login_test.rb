require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_1)
    @user.password = "password"
  end

  test "login with valid information" do
    get "/login"
    assert_response :success

    post_via_redirect "/login", email: @user.email, password: "password"
    assert_equal user_path(@user), path
  end

  test "login with invalid information" do
    get "/login"
    assert_response :success

    post "/login", email: @user.email, password: "wrong_password"

    # Check that login was unsuccesful and rendered login screen
    assert_template "sessions/new"
  end
end
