FactoryBot.define do
  factory :comment do
    content "MyString"
    user
    movie
  end
end
