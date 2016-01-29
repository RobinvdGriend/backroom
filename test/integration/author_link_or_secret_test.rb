require 'test_helper'

class AuthorLinkOrSecretTest < ActionDispatch::IntegrationTest
  def setup
    @member = User.first
    @non_member = User.offset(1).first
    @room = Room.first
    
    # Setup associations
    @room.users << @member
    @post = @room.posts.create(title: "Test Post", body: "Test body paragraph...", user: @member)
  end

  test "should not show author name of post when not logged in" do
    get post_path(@post)
    assert_select "a.post-author", "Secret"  
  end

  test "should not show author name when not member of room" do
    post login_path, email: @non_member.email, password: "password"
    assert_redirected_to user_path(@non_member)
    
    get post_path(@post)
    assert_select "a.post-author", "Secret"
  end

  test "should show author name when member of room" do
    post login_path, email: @member.email, password: "password"
    assert_redirected_to user_path(@member)
    
    get post_path(@post)
    assert_select "a.post-author", @member.name
  end
end
