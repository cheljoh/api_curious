class TumblrService

  def initialize(current_user_uid)
    @api_key = "api_key=#{ENV['CONSUMER_KEY']}"
    @host = "https://api.tumblr.com/v2/blog/#{current_user_uid}"
  end

  def info
    response = parse(HTTParty.get(@host + "/info?" + @api_key).body)
    response[:response][:blog]
  end

  def avatar
    HTTParty.get(@host + "/avatar")
  end

  private

  def parse(json_string)
    JSON.parse(json_string, symbolize_names: true)
  end

end
