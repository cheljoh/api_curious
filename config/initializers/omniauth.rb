Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, ENV['CONSUMER_KEY'], ENV['SECRET_KEY']
end
