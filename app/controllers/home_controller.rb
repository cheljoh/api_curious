class HomeController < ApplicationController

  def index
    if current_user
      @following = Blog.new(current_user).following
    end
  end

  def update
    if params[:method] == "like"
      like_post = Blog.new(current_user).like(blog_params)
      flash[:notice] = "you liked a post! <3"
      redirect_to root_path
    elsif params[:method] == "reblog"
      Blog.new(current_user).reblog(blog_params)
      flash[:notice] = "you reblogged a post! <3"
      redirect_to root_path
    end
  end

  private

  def blog_params
    params.permit(:post_id, :reblog_key)
  end
end
