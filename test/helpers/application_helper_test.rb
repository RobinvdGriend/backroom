require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @user = users(:user_1)
  end

  test "should return logged in user if logged in" do
    # Log in user by setting the session cookie
    session[:user_id] = @user.id
    assert logged_in_user == @user
  end

  test "should return false when not logged in" do
    session[:user_id] = nil
    assert_not logged_in_user
  end

end
