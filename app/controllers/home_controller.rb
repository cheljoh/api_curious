class HomeController < ApplicationController
  def index
    @following = Blog.new(current_user).following
  end
end
