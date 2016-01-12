require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_1)
    @room = rooms(:room_1)
    @post = Post.new(title: "Test title",
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
end
