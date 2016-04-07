require 'rails_helper'

RSpec.describe Blog, type: :model do

  it "returns the blog title" do
    VCR.use_cassette("blog.title") do
      title = Blog.new("cheljoh").title
      expect(title).to eq("Fun Times")
    end
  end

  it "returns total_posts" do
    VCR.use_cassette("blog.total_posts") do
      title = Blog.new("cheljoh").total_posts
      expect(title).to eq(4)
    end
  end

  it "returns post title and summary" do
    VCR.use_cassette("blog.posts") do
      posts = Blog.new("cheljoh").posts
      post1 = posts.first
      post2 = posts.last
      expect(post1[0]).to eq("Another one")
      expect(post1[1]).to eq("Look at this wow so cool.")
      expect(post2[0]).to eq("Heyyyyy")
      expect(post2[1]).to eq("Testing for an app whooooooo")
    end
  end

  it "returns photo summary and url" do
    VCR.use_cassette("blog.photos") do
      posts = Blog.new("cheljoh").photos
      post1 = posts.first
      post2 = posts.last
      post1_url = "https://36.media.tumblr.com/0b6cd63c3d10d8f900dd78f9ef99709c/tumblr_o56xtkb3Ub1vqcg1go1_500.jpg"
      post2_url = "https://41.media.tumblr.com/4ac4f4d27cff7d708dc92b00998c817a/tumblr_o56xri6XAk1vqcg1go1_250.png"
      expect(post1[:summary]).to eq("unicat dawwwwww")
      expect(post1[:photos][0]).to eq(post1_url)
      expect(post2[:summary]).to eq("kawaii manatee! awwww")
      expect(post2[:photos][0]).to eq(post2_url)
    end
  end
end
