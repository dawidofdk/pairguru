require "rails_helper"

describe Movie do
  let(:movie) { build(:movie, title: "Godfather") }

  describe "#remote_movie delegate attributes", :vcr do
    context "when remote movie found" do
      it "returns proper values" do
        expect(movie.rating).to eq 9.2
        expect(movie.plot).to eq "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son."
        expect(movie.poster).to eq "https://pairguru-api.herokuapp.com/godfather.jpg"
      end
    end

    context "when remote movie not found" do
      let(:movie) { build(:movie, title: "404 in response") }

      it "returns nil values" do
        expect(movie.rating).to be_nil
        expect(movie.plot).to be_nil
        expect(movie.poster).to be_nil
      end
    end
  end

  describe "associations" do
    it { should have_many(:comments).dependent(:destroy) }
  end
end
