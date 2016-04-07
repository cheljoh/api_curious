class Blog
  attr_reader :blog_name, :current_user

  def initialize(current_user)
    @blog_name = current_user.uid
    @current_user = current_user
  end

  def title
    info(blog_name)[:title]
  end

  def total_posts
    info(blog_name)[:total_posts]
  end

  def avatar
    get_avatar(blog_name)
  end

  def posts
    posts = get_posts(blog_name)
    post_content = posts.map do |post|
      [post[:title], post[:body].gsub("<p>", "").gsub("</p>", "")]
    end
  end

  def photos
    photos = get_photos(blog_name).map{|post| {:summary => post[:summary], :photos => post[:photos].map{|photo| photo[:alt_sizes][1][:url]}}}
  end

  def following
    blogs = get_names(current_user)["blogs"]
    names = blogs.map do |blog|
      blog["name"]
    end.first(8)
  end

  def following_photos(name)
    photos = (get_photos(name).map{|post| {:summary => post[:summary], :photos => post[:photos].map{|photo| photo[:alt_sizes][1][:url]}}}).first
  end

  private

  def info(blog_name) #took out self
    TumblrService.new(blog_name).info
  end

  def get_avatar(blog_name)
    TumblrService.new(blog_name).avatar
  end

  def get_posts(blog_name)
    TumblrService.new(blog_name).posts
  end

  def get_photos(blog_name)
    TumblrService.new(blog_name).photos
  end

  def get_names(current_user)
    TumblrService.new(blog_name).following(current_user)
  end

end
