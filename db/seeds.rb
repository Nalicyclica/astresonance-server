# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 30.times do |i|
#   music = Music.create( category_id: i%3, genre_id: i%10, user_id: 1)
#   music.music.attach(io: File.open('public/musics/ゴブリンのテーマ.mp3'), filename: 'Gobbrin.mp3', content_type: 'music/mp3')
#   music.save
# end
# 4.times do |j|
# 30.times do |i|
#   Title.create( title: "海と月", color: "#000000", user_id: j+2, music_id: i+1 )
# end
# end
4.times do |j|
90.times do |i|
  Comment.create( text: "いいタイトルですね", user_id: j+1, title_id: i+1 )
end
end