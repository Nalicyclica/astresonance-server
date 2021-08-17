# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
30.times do |i|
  music = Music.create( category_id: i%3, genre_id: i%10, user_id: 1)
  music.music.attach(io: File.open('public/musics/ゴブリンのテーマ.mp3'), filename: 'Gobbrin.mp3', content_type: 'music/mp3')
  music.save
end