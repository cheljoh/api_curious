class HomeController < ApplicationController

  def index
    if current_user
      @following = Blog.new(current_user).following
    end
  end

  def update
    like_post = Blog.new(current_user).like(like_params)
    flash[:notice] = "you liked a post!"
    redirect_to root_path
  end

  private

  def like_params
    params.permit(:post_id, :reblog_key)
  end
end
