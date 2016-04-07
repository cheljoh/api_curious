require "rails_helper"

RSpec.feature "UserViewsTheirFeed", type: :integration do
  include Capybara::DSL

  scenario "user views their feed" do
    VCR.use_cassette("blog.following_photos") do

      user = User.create(uid: "cheljoh", name: "cheljoh", oauth_token: ENV["OAUTH_TOKEN"], oauth_token_secret: ENV["OAUTH_TOKEN_SECRET"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_content("clovermemories")
      expect(page).to have_content("harusi00")
      expect(page).to have_content("textsfromtherisingstones")
      expect(page).to have_content("ffxivreactions")
      expect(page).to have_content("thedailyspriggan")
      expect(page).to have_content("skellydun")
      expect(page).to have_content("jigglypuffsvevo")
      expect(page).to have_content("misjudgments")

    end
  end
end
