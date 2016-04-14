class PagesController < ApplicationController
  def homepage
    @posts = Post.latest(10)
  end

  def style_guide
  end
end
