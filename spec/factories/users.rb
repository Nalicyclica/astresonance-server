FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { "#{Faker::Internet.password(min_length: 4)}1a" }
    icon_color { Faker::Color.hex_color }
  end
end
