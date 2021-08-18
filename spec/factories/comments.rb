FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence(word_count: 5) }
    association :user
    association :title
  end
end
