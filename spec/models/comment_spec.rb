require 'rails_helper'

describe Comment, type: :model do
  describe "associations" do
    it "checks", :aggregate_failures do
      should belong_to(:user).class_name("User")
      should belong_to(:movie).class_name("Movie")
    end
  end
end
