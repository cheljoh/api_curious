class HomeController < ApplicationController

  def index
    if current_user
      @following = Blog.new(current_user).following
    end
  end
end
