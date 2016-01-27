module PostsHelper
  def author_link_or_secret(post)
    if post.is_secret?(current_user)
      return link_to "Secret", "#", class: "post-author is-secret"
    else
      return link_to post.user.name, user_path(post.user), class: "post-author"
    end
  end
end
