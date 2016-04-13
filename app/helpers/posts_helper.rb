module PostsHelper
  def author_link_or_secret(post)
    if post.is_secret?(current_user)
      return "Secret"
    else
      return link_to post.user.name, user_path(post.user)
    end
  end
end
