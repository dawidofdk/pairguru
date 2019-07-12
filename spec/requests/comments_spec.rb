require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /movies/:id", :vcr do
    let!(:comment) { create(:comment) }

    it "displays comments on movie page" do
      visit movie_path(comment.movie)

      expect(page).to have_selector(".panel-body", text: comment.content)
      expect(page).to have_selector(".commented_user", text: comment.user.email)
    end
  end

  describe "display top 10 commenters" do
    before do
      create_list :user, 5
      create_list :movie, 5

      User.limit(3).pluck(:id).each do |user_id|
        create :comment, movie: Movie.first, user_id: user_id
      end

      Movie.offset(1).limit(3).pluck(:id).each do |movie_id|
        create :comment, movie_id: movie_id, user: User.second
      end

      create :comment, movie: Movie.last, user: User.third
    end

    it "displays  top 10 commenters" do
      visit "/top_10_commenters"

      expect(page.body.gsub(/<\/?[^>]+>/, '')).to include("1.\n#{User.second.email}\n4")
      expect(page.body.gsub(/<\/?[^>]+>/, '')).to include("2.\n#{User.third.email}\n2")
      expect(page.body.gsub(/<\/?[^>]+>/, '')).to include("3.\n#{User.first.email}\n1")
    end
  end
end
