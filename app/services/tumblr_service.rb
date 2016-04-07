require "base64"
require "oauth"

class TumblrService

  def initialize(blog_name = "")
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

  def avatar
    response = HTTParty.get(@host + "/avatar/64")
    Base64.strict_encode64(response)
  end

  def like(current_user, params)
    configure_tumblr_client(current_user)
    client = Tumblr::Client.new
    client.like(params[:post_id].to_i, params[:reblog_key])
  end

  def reblog(current_user, params)
    configure_tumblr_client(current_user)
    cleaned_params = {'post_id' => params[:post_id].to_i, 'reblog_key' => params[:reblog_key]}
    client = Tumblr::Client.new
    #client.reblog(params[:post_id], params[:reblog_key])
  end

  def following(current_user)
    configure_tumblr_client(current_user)
    client = Tumblr::Client.new
    client.following
  end

  def configure_tumblr_client(current_user)
    Tumblr.configure do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['SECRET_KEY']
      config.oauth_token = current_user.oauth_token
      config.oauth_token_secret = current_user.oauth_token_secret
    end
  end

    # http_method = "GET"
    # base_url = "api.tumblr.com/v2/user/following"
    # parameters = [["oauth_consumer_key", ""],
    #               ["oauth_token", ""],
    #               ["oauth_signature_method", "HMAC-SHA1"],
    #               ["oauth_timestamp", "1460001937"],
    #               ["oauth_nonce", "CImbuF"],
    #               ["oauth_version", "1.0"]]
    #
    # url_encoded = parameters.map{|pair| [URI::escape(pair[0]), URI::escape(pair[1])]} #url encode the key/values
    # url_encoded_sorted = url_encoded.sort_by{|pair| pair[0]} #sort by encoded key
    # parameter_string = url_encoded_sorted.map{|pair| pair[0].to_s + "=" + pair[1].to_s}.join("&")
    # base_string_to_sign = http_method + "&" + URI::escape(base_url) + "&" + URI::escape(parameter_string)
    #
    # request = "api.tumblr.com/v2/user/following?oauth_consumer_key=&oauth_token=&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1460001937&oauth_nonce=&oauth_version=1.0"
    #
    # consumer_secret_key = ""
    # oauth_token_secret = ""
    # options = {:consumer_secret => consumer_secret_key, :token_secret => oauth_token_secret}
    # request_proxy = OAuth::RequestProxy::Base.new(request, {}) #no unsigned parameters
    # o = OAuth::Signature::HMAC::SHA1.new(request_proxy, options)
    #
    # encode_key = URI::escape(consumer_secret_key) + "&" + URI::escape(oauth_token_secret)
    # signature = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1', encode_key, base_string_to_sign)}").chomp)
    # request = base_string_to_sign + "&oauth_signature=" + signature
    #
    # base_string_to_sign = ""
    #
    # encode_key = ""
    # signature = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',encode_key, base_string_to_sign)}").chomp)
    #
    # signature_string = "&oauth_signature=#{signature}"
    # #headers = {"Authorization" => consumer_key + consumer_secret + oauth_token + oauth_token_secret}
    # # HTTParty.get(host, headers: headers).body
    # HTTParty.get(host + consumer_key + oauth_token + oauth_signature_method + timestamp + nonce + version + signature_string)

  # def hmac_sha1(data, secret)
  #   OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret.encode("ASCII"), data.encode("ASCII"))
  # end
  #
  # def get_timestamp
  #   Time.now.to_i
  # end
  #
  # def get_nonce
  #   rand(10 ** 30).to_s.rjust(30,'0')
  # end

  private

  def parse(json_string)
    JSON.parse(json_string, symbolize_names: true)
  end

end
