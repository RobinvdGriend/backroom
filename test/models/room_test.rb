require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = Room.new(name: "Example Room")
    @user = User.first
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
    # We can't add users to an unsaved room
    @room.save

    assert_difference("@room.memberships.count", 1) do
      @room.add_user(@user)
    end

    assert_equal "member", @room.memberships.first.role
  end

  test "add_user with role: :member should add user as member" do
    # We can't add users to an unsaved room
    @room.save
    @room.add_user(@user, role: :member)
    
    assert_equal "member", @room.memberships.first.role
  end

  test "add_user with role: :moderator should add user as moderator" do
    # We can't add users to an unsaved room
    @room.save
    @room.add_user(@user, role: :moderator)

    assert_equal "moderator", @room.memberships.first.role
  end

  test "update_role should change the role of a member" do
    # We can't add users to an unsaved room
    @room.save
    @room.add_user(@user, role: :member)

    @room.update_role(user: @user, role: :moderator)
    assert_equal "moderator", @room.memberships.first.role
  end

  test "update_role with missing arguments should raise an error" do
    # We can't add users to an unsaved room
    @room.save

    assert_raises { @room.update_role }
    assert_raises { @room.update_role user: @user }
    assert_raises { @room.update_role role: :member }
  end
end
