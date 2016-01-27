class PostsController < ApplicationController
  def create
    @room = Room.find_by(id: params[:id])
    @post = @room.posts.create(post_params)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:body, :title, :user_id, :room_id)
  end
end
