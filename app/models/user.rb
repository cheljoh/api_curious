class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid = auth_info.uid
      new_user.name = auth_info.extra.raw_info.name
      new_user.oauth_token = auth_info.credentials.token #there is no screename
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end

# pry(#<SessionsController>)> request.env["omniauth.auth"]
# => {"provider"=>"tumblr",
# "uid"=>"cheljoh",
# "info"=>
#  {"nickname"=>"cheljoh",
#   "name"=>"cheljoh",
#   "blogs"=>[{"name"=>"cheljoh", "url"=>"http://cheljoh.tumblr.com/", "title"=>"Untitled"}],
#   "avatar"=>"https://secure.assets.tumblr.com/images/default_avatar/cone_open_64.png"},
# "credentials"=>{"token"=>"uCFdnP16meP725DHAeNPUuquo4wVqIMeQjFThoG51xluO15S5E", "secret"=>"g6bZIe0HT3zEEn4Q8mEngNnIvzkug9IgliRTQxxuw4NeXmD0nU"},
# "extra"=>
#  {"access_token"=>
#    #<OAuth::AccessToken:0x007fd450ec05c8
#     @consumer=
#      #<OAuth::Consumer:0x007fd450eda9a0
#       @http=#<Net::HTTP www.tumblr.com:443 open=false>,
#       @http_method=:post,
#       @key="8uRWiERY6XBSAc7kA4SCq3jpANHkxvmTNbPdIpSilhmFZuuXY4",
#       @options=
#        {:signature_method=>"HMAC-SHA1",
#         :request_token_path=>"/oauth/request_token",
#         :authorize_path=>"/oauth/authorize",
#         :access_token_path=>"/oauth/access_token",
#         :proxy=>nil,
#         :scheme=>:header,
#         :http_method=>:post,
#         :oauth_version=>"1.0",
#         :site=>"https://www.tumblr.com"},
#       @secret="PNNXIsbUkQ1meTbjI9aaIOTMx2dK1j10uQfTGu0lDgBbCAHJFM",
#       @uri=#<URI::HTTPS https://www.tumblr.com>>,
#     @params=
#      {:oauth_token=>"uCFdnP16meP725DHAeNPUuquo4wVqIMeQjFThoG51xluO15S5E",
#       "oauth_token"=>"uCFdnP16meP725DHAeNPUuquo4wVqIMeQjFThoG51xluO15S5E",
#       :oauth_token_secret=>"g6bZIe0HT3zEEn4Q8mEngNnIvzkug9IgliRTQxxuw4NeXmD0nU",
#       "oauth_token_secret"=>"g6bZIe0HT3zEEn4Q8mEngNnIvzkug9IgliRTQxxuw4NeXmD0nU"},
#     @response=#<Net::HTTPMovedPermanently 301 Moved Permanently readbody=true>,
#     @secret="g6bZIe0HT3zEEn4Q8mEngNnIvzkug9IgliRTQxxuw4NeXmD0nU",
#     @token="uCFdnP16meP725DHAeNPUuquo4wVqIMeQjFThoG51xluO15S5E">,
#   "raw_info"=>
#    {"name"=>"cheljoh",
#     "likes"=>0,
#     "following"=>1,
#     "default_post_format"=>"html",
#     "blogs"=>
#      [{"title"=>"Untitled",
#        "name"=>"cheljoh",
#        "total_posts"=>1,
#        "posts"=>1,
#        "url"=>"http://cheljoh.tumblr.com/",
#        "updated"=>1459800991,
#        "description"=>"",
#        "is_nsfw"=>false,
#        "ask"=>false,
#        "ask_page_title"=>"Ask me anything",
#        "ask_anon"=>false,
#        "followed"=>false,
#        "can_send_fan_mail"=>true,
#        "is_blocked_from_primary"=>false,
#        "share_likes"=>true,
#        "likes"=>0,
#        "twitter_enabled"=>false,
#        "twitter_send"=>false,
#        "facebook_opengraph_enabled"=>"N",
#        "tweet"=>"N",
#        "facebook"=>"N",
#        "followers"=>0,
#        "primary"=>true,
#        "admin"=>true,
#        "messages"=>0,
#        "queue"=>0,
#        "drafts"=>0,
#        "type"=>"public",
#        "reply_conditions"=>2,
#        "subscribed"=>false,
#        "can_subscribe"=>false}],
#     "avatar"=>"https://secure.assets.tumblr.com/images/default_avatar/cone_open_64.png"}}}
