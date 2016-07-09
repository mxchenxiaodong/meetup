FactoryGirl.define do
  factory :topic do
    sequence(:title)  { |n| "Title #{n}" }
    sequence(:content)  { |n| "content #{n}" }
    user
  end
end