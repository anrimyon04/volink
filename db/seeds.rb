# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Tag.destroy_all
Tag.create([
  { name: '自然・環境' },
  { name: '災害' },
  { name: '医療・福祉' },
  { name: 'グローバル' },
  { name: 'スポーツ' },
  { name: 'ダイバーシティ' },
  { name: 'まちづくり' },
  { name: '文化・芸術' },
  { name: '教育' },
])

10.times do |n|
  latitude = Faker::Address.latitude.to_f
  longitude = Faker::Address.longitude.to_f
  Post.create!(
    title: "Example Title #{n + 1}",
    address: "Example Address #{n + 1}",
    latitude: latitude,
    longitude: longitude,
  )
end