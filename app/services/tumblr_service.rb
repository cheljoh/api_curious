require "base64"

class TumblrService

  def initialize(blog_name)
    @api_key = "api_key=#{ENV['CONSUMER_KEY']}"
    @host = "https://api.tumblr.com/v2/blog/#{blog_name}"
  end

  def info
    response = parse(HTTParty.get(@host + "/info?" + @api_key).body)
    response[:response][:blog]
  end

  def posts
    response = parse(HTTParty.get(@host + "/posts/text?" + @api_key).body)
    response[:response][:posts]
  end

  def photos
    response = parse(HTTParty.get(@host + "/posts/photo?" + @api_key).body)
    response[:response][:posts]
  end

  # text, quote, link, answer, video, audio, photo, chat. Get videos?
  #NEXT- feed of people
  #/user/following – Retrieve the Blogs a User Is Following

  def avatar
    response = HTTParty.get(@host + "/avatar/64")
    Base64.strict_encode64(response)
  end

  def following

  end

  private

  def parse(json_string)
    JSON.parse(json_string, symbolize_names: true)
  end

end


# {:meta=>{:status=>200, :msg=>"OK"},
#  :response=>
#   {:blog=>
#     {:title=>"Fun Times",
#      :name=>"cheljoh",
#      :total_posts=>4,
#      :posts=>4,
#      :url=>"http://cheljoh.tumblr.com/",
#      :updated=>1459910073,
#      :description=>"",
#      :is_nsfw=>false,
#      :ask=>false,
#      :ask_page_title=>"Ask me anything",
#      :ask_anon=>false,
#      :share_likes=>true,
#      :likes=>0},
#    :posts=>
#     [{:blog_name=>"cheljoh",
#       :id=>142327511406,
#       :post_url=>"http://cheljoh.tumblr.com/post/142327511406/unicat-dawwwwww",
#       :slug=>"unicat-dawwwwww",
#       :type=>"photo",
#       :date=>"2016-04-06 02:34:32 GMT",
#       :timestamp=>1459910072,
#       :state=>"published",
#       :format=>"html",
#       :reblog_key=>"nWa0qOer",
#       :tags=>[],
#       :short_url=>"https://tmblr.co/ZhhVQh24ZONbk",
#       :summary=>"unicat dawwwwww",
#       :recommended_source=>nil,
#       :recommended_color=>nil,
#       :highlighted=>[],
#       :note_count=>0,
#       :caption=>"<p>unicat dawwwwww</p>",
#       :reblog=>{:tree_html=>"", :comment=>"<p>unicat dawwwwww</p>"},
#       :trail=>
#        [{:blog=>
#           {:name=>"cheljoh",
#            :active=>true,
#            :theme=>
#             {:avatar_shape=>"square",
#              :background_color=>"#FAFAFA",
#              :body_font=>"Helvetica Neue",
#              :header_bounds=>"",
#              :header_image=>"https://secure.assets.tumblr.com/images/default_header/optica_pattern_08.png?_v=f0f055039bb6136b9661cf2227b535c2",
#              :header_image_focused=>"https://secure.assets.tumblr.com/images/default_header/optica_pattern_08_focused_v3.png?_v=f0f055039bb6136b9661cf2227b535c2",
#              :header_image_scaled=>"https://secure.assets.tumblr.com/images/default_header/optica_pattern_08_focused_v3.png?_v=f0f055039bb6136b9661cf2227b535c2",
#              :header_stretch=>true,
#              :link_color=>"#529ECC",
#              :show_avatar=>true,
#              :show_description=>true,
#              :show_header_image=>true,
#              :show_title=>true,
#              :title_color=>"#86649b",
#              :title_font=>"Gibson",
#              :title_font_weight=>"bold"},
#            :share_likes=>true,
#            :share_following=>true},
#          :post=>{:id=>"142327511406"},
#          :content_raw=>"<p>unicat dawwwwww</p>",
#          :content=>"<p>unicat dawwwwww</p>",
#          :is_current_item=>true,
#          :is_root_item=>true}],
#       :image_permalink=>"http://cheljoh.tumblr.com/image/142327511406",
#       :photos=>
#        [{:caption=>"",
#          :alt_sizes=>
#           [{:url=>"https://40.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_1280.jpg", :width=>720, :height=>445},
#            {:url=>"https://36.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_500.jpg", :width=>500, :height=>309},
#            {:url=>"https://40.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_400.jpg", :width=>400, :height=>247},
#            {:url=>"https://40.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_250.jpg", :width=>250, :height=>155},
#            {:url=>"https://40.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_100.jpg", :width=>100, :height=>62},
#            {:url=>"https://41.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_75sq.jpg", :width=>75, :height=>75}],
#          :original_size=>{:url=>"https://40.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_1280.jpg", :width=>720, :height=>445}}]},
#      {:blog_name=>"cheljoh",
#       :id=>142327450036,
#       :post_url=>"http://cheljoh.tumblr.com/post/142327450036/kawaii-manatee-awwww",
#       :slug=>"kawaii-manatee-awwww",
#       :type=>"photo",
#       :date=>"2016-04-06 02:33:18 GMT",
#       :timestamp=>1459909998,
#       :state=>"published",
#       :format=>"html",
#       :reblog_key=>"x8uneSwS",
#       :tags=>[],
#       :short_url=>"https://tmblr.co/ZhhVQh24ZO8cq",
#       :summary=>"kawaii manatee! awwww",
#       :recommended_source=>nil,
#       :recommended_color=>nil,
#       :highlighted=>[],
#       :note_count=>0,
#       :caption=>"<p>kawaii manatee! awwww</p>",
#       :reblog=>{:tree_html=>"", :comment=>"<p>kawaii manatee! awwww</p>"},
#       :trail=>
#        [{:blog=>
#           {:name=>"cheljoh",
#            :active=>true,
#            :theme=>
#             {:avatar_shape=>"square",
#              :background_color=>"#FAFAFA",
#              :body_font=>"Helvetica Neue",
#              :header_bounds=>"",
#              :header_image=>"https://secure.assets.tumblr.com/images/default_header/optica_pattern_08.png?_v=f0f055039bb6136b9661cf2227b535c2",
#              :header_image_focused=>"https://secure.assets.tumblr.com/images/default_header/optica_pattern_08_focused_v3.png?_v=f0f055039bb6136b9661cf2227b535c2",
#              :header_image_scaled=>"https://secure.assets.tumblr.com/images/default_header/optica_pattern_08_focused_v3.png?_v=f0f055039bb6136b9661cf2227b535c2",
#              :header_stretch=>true,
#              :link_color=>"#529ECC",
#              :show_avatar=>true,
#              :show_description=>true,
#              :show_header_image=>true,
#              :show_title=>true,
#              :title_color=>"#86649b",
#              :title_font=>"Gibson",
#              :title_font_weight=>"bold"},
#            :share_likes=>true,
#            :share_following=>true},
#          :post=>{:id=>"142327450036"},
#          :content_raw=>"<p>kawaii manatee! awwww</p>",
#          :content=>"<p>kawaii manatee! awwww</p>",
#          :is_current_item=>true,
#          :is_root_item=>true}],
#       :image_permalink=>"http://cheljoh.tumblr.com/image/142327450036",
#       :photos=>
#        [{:caption=>"",
#          :alt_sizes=>
#           [{:url=>"https://40.media.tumblr.com/4ac4f4d27cff7d708dc92b00998c817a/tumblr_o56xri6XAk1vqcg1go1_400.png", :width=>400, :height=>339},
#            {:url=>"https://41.media.tumblr.com/4ac4f4d27cff7d708dc92b00998c817a/tumblr_o56xri6XAk1vqcg1go1_250.png", :width=>250, :height=>212},
#            {:url=>"https://40.media.tumblr.com/4ac4f4d27cff7d708dc92b00998c817a/tumblr_o56xri6XAk1vqcg1go1_100.png", :width=>100, :height=>85},
#            {:url=>"https://41.media.tumblr.com/4ac4f4d27cff7d708dc92b00998c817a/tumblr_o56xri6XAk1vqcg1go1_75sq.png", :width=>75, :height=>75}],
#          :original_size=>{:url=>"https://40.media.tumblr.com/4ac4f4d27cff7d708dc92b00998c817a/tumblr_o56xri6XAk1vqcg1go1_400.png", :width=>400, :height=>339}}]}],
#    :total_posts=>2}}
