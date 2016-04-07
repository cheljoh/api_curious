class Blog
  attr_reader :blog_name

  def initialize(blog_name)
    @blog_name = blog_name
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

end
