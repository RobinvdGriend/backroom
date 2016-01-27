class RoomsController < ApplicationController
  before_action :require_member, only: [:show]

  def show
    @posts = @room.posts.last(30)
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You need to be logged in to visit a room's page"
      redirect_to login_path
    end
  end

  def require_member
    @room = Room.find(params[:id])
    @room.is_member?(current_user)
  end
end
