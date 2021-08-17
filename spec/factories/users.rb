FactoryBot.define do
  factory :user do
    nickname { Faker::Artist.name }
    email { Faker::Internet.free_email }
    password { "#{Faker::Internet.password(min_length: 4)}1a" }
    password_confirmation { password }
    icon_color { Faker::Color.hex_color }
  end
end
