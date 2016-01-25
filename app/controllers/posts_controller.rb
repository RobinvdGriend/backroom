class PostsController < ApplicationController
  def create
    @room = Room.find_by(id: params[:id])
    @post = @room.posts.create(post_params)
  end
end
