require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.first
    @other_user = User.offset(1).first
    @room = Room.first
    
    @room.users << @user
  end

  test "room should have member" do
    assert @room.memberships.exists?(user_id: @user.id)
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

  test "is_room_member? should return true if user is a member of room" do
    assert @user.is_room_member?(@room)
  end

  test "is_room_member? should return false if user is not a member of room" do
    @room.users.destroy(@user)
    assert_not @user.is_room_member?(@room)
  end

  test "is_room_member? should raise an error if room argument is invalid" do
    assert_raises { @user.is_room_member?(String.new) }
  end

  test "is_room_moderator? should return true if user is a moderator of room" do
    @room.memberships.find_by(user_id: @user.id).update(role: :moderator)
    assert @user.is_room_moderator?(@room)
  end

  test "is_room_moderator? should return false if user is not a moderator of room" do
    assert_not @user.is_room_moderator?(@room)
  end

  test "is_room_moderator? should return false if user is not in room" do
    @room.users.destroy(@user)
    assert_not @user.is_room_moderator?(@room)
  end

  test "is_room_moderator? should raise an error if room argument is invalid" do
    assert_raises { @user.is_room_moderator?(String.new) }
  end
end
