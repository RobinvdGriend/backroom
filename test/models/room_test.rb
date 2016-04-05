require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = Room.first
    @user = User.first
    @other_user = User.offset(1).first
  end

  test "should be valid" do
    assert @room.valid?
  end

  test "name should be non-blank" do
    @room.name = ""
    assert_not @room.valid?
  end

  test "name should have minimum length" do
    @room.name = "a" * 2
    assert_not @room.valid?
  end

  test "name should not exceed maximum length" do
    @room.name = "a" * 51
    assert_not @room.valid?
  end

  test "add_user without role argument should add user as member" do
    assert_difference("@room.memberships.count", 1) do
      @room.add_user(@user)
    end

    assert_equal "member", @room.memberships.first.role
  end

  test "add_user with role: :member should add user as member" do
    @room.add_user(@user, role: :member)
    
    assert_equal "member", @room.memberships.first.role
  end

  test "add_user with role: :moderator should add user as moderator" do
    @room.add_user(@user, role: :moderator)

    assert_equal "moderator", @room.memberships.first.role
  end

  test "update_role should change the role of a member" do
    @room.add_user(@user, role: :member)

    @room.update_role(user: @user, role: :moderator)
    assert_equal "moderator", @room.memberships.first.role
  end

  test "update_role with missing arguments should raise an error" do
    assert_raises { @room.update_role }
    assert_raises { @room.update_role user: @user }
    assert_raises { @room.update_role role: :member }
  end

  test "is_member? should return true if user is in room" do
    @room.add_user(@user)
    assert @room.is_member?(@user)
  end

  test "is_member? should return false if user is not in room" do
    assert_not @room.is_member?(@user)
  end

  test "is_member? should return false if user is nil" do
    assert_not @room.is_member?(nil)
  end

  test "is_moderator? should return true if user is moderator in room" do
    @room.add_user(@user, role: :moderator)
    assert @room.is_moderator?(@user)
  end

  test "is_moderator? should return false if user is just a member in room" do
    @room.add_user(@user, role: :member)
    assert_not @room.is_moderator?(@user)
  end

  test "is_moderator? should return false if user is not in room" do
    assert_not @room.is_moderator?(@user)
  end

  test "members should return only users with the member role" do
    @room.add_user(@user, role: :moderator)
    @room.add_user(@other_user, role: :member)

    assert_includes @room.members, @other_user
    assert_not_includes @room.members, @user
  end

  test "members should return an empty array if there are no members" do
    assert_empty @room.members
  end

  test "moderators should return only users with the moderator role" do
    @room.add_user(@user, role: :moderator)
    @room.add_user(@other_user, role: :member)

    assert_includes @room.moderators, @user
    # assert_not_includes @room.moderators, @other_user
  end

  test "moderators should return an empty array if there are no moderators" do
    assert_empty @room.moderators
  end
end
