require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_1)
    @other_user = users(:user_2)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be non-blank" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should have minimum length" do
    @user.name = "a" * 2
    assert_not @user.valid?
  end

  test "name should not exceed maximum length" do
    @user.name = "2" * 22
    assert_not @user.valid?
  end

  test "name should be unique" do
    @user.name = @other_user.name
    @other_user.save!

    assert_not @user.valid?
  end

  test "email should be non-blank" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email should not exceed maximum length" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end
end
