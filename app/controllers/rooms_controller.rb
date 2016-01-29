class RoomsController < ApplicationController
  def index
    @rooms = Room.limit(30)
  end

  def show
    @room = Room.find(params[:id])
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
    
    unless @room.is_member?(current_user)
      flash[:error] = "You need to be a member of a room to visit it's page"
      redirect_to root_path
    end
  end
end
