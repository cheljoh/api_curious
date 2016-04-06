class UsersController < ApplicationController
  before_action :require_user, only: [:index]
  def index

  end

  def show
    @title = Blog.title(current_user.uid)
    @total_posts = Blog.total_posts(current_user.uid)
    @avatar = Blog.avatar(current_user.uid)
    @recent_posts = Blog.posts(current_user.uid)
    @posts = Blog.photos(current_user.uid)
  end
end



# Build a basic version of the Tumblr UI. As a user, I should be able to:
#
# Authenticate with my Tumblr account
# See my basic profile information (username, profile pic)
# View a list of recent posts from my feed
# View embedded photo or video content for the posts
# Favorite a post
# Reblog a post
