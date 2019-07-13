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
end
