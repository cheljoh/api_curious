require "rails_helper"

RSpec.feature "UserReblogsPost", type: :integration do
  include Capybara::DSL

  scenario "user reblogs a post" do
    VCR.use_cassette("blog.following_photos") do

      user = User.create(uid: "cheljoh", name: "cheljoh", oauth_token: ENV["OAUTH_TOKEN"], oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      within("#clovermemories") do
        click_on "reblog"
      end

      expect(page).to have_content("you reblogged a post!")
    end
  end
end
