require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:user_1)
  end

  test "logged_in_user should return logged in user if logged in" do
    # Log in user by setting the session cookie
    session[:user_id] = @user.id
    assert logged_in_user == @user
  end

  test "logged_in_user should return false when not logged in" do
    session[:user_id] = nil
    assert_not logged_in_user
  end

  test "should create user with valid signup information" do
    assert_difference "User.count", 1 do
      post :create, user: { name: Faker::Internet.user_name,
                            email: Faker::Internet.safe_email, 
                            password: "password",
                            password_confirmation: "password" }
    end
  end

  test "should not create user with invalid signup information" do
    assert_no_difference "User.count" do
      post :create, user: { name: "",
                            email: "", 
                            password: "invalid",
                            password_confirmation: "wrong" }
    end
  end
end
