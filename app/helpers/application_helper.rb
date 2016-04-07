module ApplicationHelper
  def new_blog(name)
    Blog.new(current_user).following_photos(name)
  end
end
