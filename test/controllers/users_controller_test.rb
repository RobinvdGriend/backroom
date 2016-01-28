require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = User.first
    @other_user = User.offset(1).first
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

  test "should login user upon signup" do
    post :create, user: { name: "Test User",
                          email: "testuser@example.com",
                          password: "password",
                          password_confirmation: "password" }
    assert_not session[:user_id].nil?
  end

  test "should only show edit profile linked when user accesses their own page" do
    get :show, id: @user.id
    assert_select "a[href=?]", edit_user_path(@user), false

    session[:user_id] = @user.id

    get :show, id: @user.id
    assert_select "a[href=?]", edit_user_path(@user)
  end

  test "should be redirected when trying to access the edit page of another user" do
    session[:user_id] = @other_user.id

    get :edit, id: @user.id
    assert_redirected_to root_path
  end
end
