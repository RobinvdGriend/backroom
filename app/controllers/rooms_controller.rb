class RoomsController < ApplicationController
  before_action :require_member, only: [:show]

  def show
    @posts = @room.posts.last(30)
  end

  private

  def require_member
    @room = Room.find(params[:id])

    unless @room.users.find_by(id: logged_in_user.id)
      flash[:error] = "You have to be a member to visit a room's page"
      redirect_to root_path
    end
  end
end
