class Blog < OpenStruct

  def self.title(current_user_uid)
    info(current_user_uid)[:title]
  end

  def self.total_posts(current_user_uid)
    info(current_user_uid)[:total_posts]
  end

  def self.avatar(current_user_uid)
    get_avatar(current_user_uid)
  end

  def self.posts(current_user_uid)
    get_posts(current_user_uid)
  end

  def self.photos(current_user_uid)
    get_photos(current_user_uid).map{|post| {:summary => post[:summary], :photos => post[:photos].map{|photo| photo[:alt_sizes][1][:url]}}}
  end

  private

  def self.info(current_user_uid)
    TumblrService.new(current_user_uid).info
  end

  def self.get_avatar(current_user_uid)
    TumblrService.new(current_user_uid).avatar
  end

  def self.get_posts(current_user_uid)
    TumblrService.new(current_user_uid).posts
  end

  def self.get_photos(current_user_uid)
    TumblrService.new(current_user_uid).photos
  end

end
