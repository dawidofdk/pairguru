require "rails_helper"

describe "Movies requests", type: :request do
  let!(:movie) { create :movie, title: "Kill Bill" }
  let(:kill_bill_rating) { 8.1 }
  let(:kill_bill_image) { "https://pairguru-api.herokuapp.com/kill_bill.jpg" }
  let(:kill_bill_plot) { "The Bride wakens from a four-year coma. The child she carried in her womb is gone. Now she must wreak vengeance on the team of assassins who betrayed her - a team she was once part of." }

  describe "movies list", :vcr do
    context "when remote movie found" do
      it "displays content" do
        visit "/movies"
        expect(page).to have_selector("h1", text: "Movies")
        expect(page).to have_css("img[src='#{kill_bill_image}']")
        expect(page).to have_selector("p.plot", text: kill_bill_plot)
        expect(page).to have_selector(".rating", text: "Rating: #{kill_bill_rating}")
      end
    end

    context "when remote movie not found" do
      let!(:movie) { create :movie, title: "Kill Bill 5" }

      it "displays empty content" do
        visit "/movies"
        expect(page).to have_selector("h1", text: "Movies")
        expect(page).not_to have_css("img")
        expect(page).to have_selector("p.plot", text: "")
        expect(page).to have_selector(".rating", text: "")
      end
    end
  end

  describe "movie page", :vcr do
    context "when remote movie found" do
      it "displays content" do
        visit "/movies/#{movie.id}"
        expect(page).to have_css("img[src='#{kill_bill_image}']")
        expect(page).to have_selector(".jumbotron", text: kill_bill_plot)
        expect(page).to have_selector(".rating", text: "Rating: #{kill_bill_rating}")
      end
    end

    context "when remote movie not found" do
      let!(:movie) { create :movie, title: "Kill Bill 5" }

      it "displays empty content" do
        visit "/movies/#{movie.id}"
        expect(page).not_to have_css("img")
        expect(page).to have_selector(".jumbotron", text: "")
        expect(page).to have_selector(".rating", text: "")
      end
    end
  end
end
