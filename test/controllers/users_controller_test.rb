require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should create user with valid signup information" do
    assert_difference "User.count", 1 do
      post :create, user: { name: Faker::Internet.user_name,
                            email: Faker::Internet.safe_email, 
                            password: "password",
                            password_confirmation: "password" }
    end
  end
end
