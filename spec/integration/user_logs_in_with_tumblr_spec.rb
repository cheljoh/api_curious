require "rails_helper"

RSpec.feature "UserLogsInWithTumblr", type: :integration do
  include Capybara::DSL

  before(:each) do
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  scenario "logging in" do
    VCR.use_cassette("blog.following_photos") do
      user = User.create(uid: "horace", name: "horace", oauth_token: ENV["OAUTH_TOKEN"], oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"
      expect(page.status_code).to eq(200)
      expect(page).to have_content("horace")
      expect(page).to have_link("Logout")
    end
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
   OmniAuth.config.test_mode = true
   # then, provide a set of fake oauth data that
   # omniauth will use when a user tries to authenticate:
   OmniAuth.config.mock_auth[:tumblr] = OmniAuth::AuthHash.new({
     provider: 'tumblr',
     extra: {
       raw_info: {
         uid: "1234",
         name: "Horace",
       }
     },
     credentials: {
       token: "pizza",
       secret: "secretpizza"
     }
   })
  end
end
