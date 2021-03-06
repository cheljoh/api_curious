require "rails_helper"

RSpec.feature "UserLogsInWithTumblr", type: :integration do
  include Capybara::DSL

  before(:each) do
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  scenario "logging in" do
    VCR.use_cassette("blog.following_photos") do
      visit "/"
      expect(page.status_code).to eq(200)
      click_on "Sign in with Tumblr"
      expect(page).to have_content("Horace")
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
