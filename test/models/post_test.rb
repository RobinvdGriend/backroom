require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.first
    @room = Room.first
    @post = Post.create(title: "Test title",
                        body: "Example test for test post",
                        user_id: @user.id,
                        room_id: @room.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be non-blank" do
    @post.title = ""
    assert_not @post.valid?
  end

  test "title should have a minimum length" do
    @post.title = "a" * 2
    assert_not @post.valid?
  end
  
  test "title should not exceed maximum length" do
    @post.title = "a" * 121
    assert_not @post.valid?
  end

  test "user_id should not be blank" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "room_id should not be blank" do
    @post.room_id = nil
    assert_not @post.valid?
  end

  test "is_secret? should return false if user is member" do
    @room.users << @user
    assert_not @post.is_secret?(@user)
  end

  test "is_secret? should return true if user is not member" do
    assert @post.is_secret?(@user)
  end

  test "is_secret? should return true if user is nil" do
    assert @post.is_secret?(nil)
  end
end
