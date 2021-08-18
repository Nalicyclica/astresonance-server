FactoryBot.define do
  factory :title do
    title { Faker::Lorem.sentence(word_count: 3) }
    color { Faker::Color.hex_color }
    association :user
    association :music
  end
end
