class PagesController < ApplicationController
  def homepage
    @posts = Post.last(10)
  end

  def style_guide
  end
end
