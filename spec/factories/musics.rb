FactoryBot.define do
  factory :music do
    category_id { Faker::Number.within(range: 0..2) }
    genre_id { Faker::Number.within(range: 0..9) }
    association :user

    after(:build) do |music|
      music.music.attach(io: File.open('public/musics/ゴブリンのテーマ.mp3'), filename: 'Gobbrin.mp3', content_type: 'music/mp3')
    end
  end
end
