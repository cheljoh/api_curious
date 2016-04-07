class UsersController < ApplicationController
  before_action :require_user, only: [:index]
  def index

  end

  def show #should use a presenter for this
    @blog = Blog.new(current_user.uid) #title and total posts
    #@posts = Blog.new(current_user.uid).photos
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
