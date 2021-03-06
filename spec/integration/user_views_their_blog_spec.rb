require "rails_helper"

RSpec.feature "UserViewsTheirBlog", type: :integration do
  include Capybara::DSL

  scenario "user sees their info" do
    VCR.use_cassette("tumblr_service#info") do

      user = User.create(uid: "cheljoh", name: "cheljoh", oauth_token: ENV["OAUTH_TOKEN"], oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "users/#{user.id}"

      expect(page).to have_content("Fun Times")
      expect(page).to have_content("Total Posts: 4")
      expect(page).to have_content("Another one")
      expect(page).to have_content("Testing for an app whooooooo")
      expect(page).to have_content("unicat dawwwwww")
      expect(page).to have_content("kawaii manatee! awwww")
    end
  end
end
