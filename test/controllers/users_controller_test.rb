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

  test "should not create user with invalid signup information" do
    assert_no_difference "User.count" do
      post :create, user: { name: "",
                            email: "", 
                            password: "invalid",
                            password_confirmation: "wrong" }
    end
  end
end
