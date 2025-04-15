# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
initial_drinks = [
  { name: "Monster Ultra Sunrise", serv_count: 2, serv_caffeine: 75 },
  { name: "Black Coffee", serv_count: 1, serv_caffeine: 95 },
  { name: "Americano", serv_count: 1, serv_caffeine: 77 },
  { name: "Sugar free NOS ", serv_count: 2, serv_caffeine: 130 },
  { name: "5 Hour Energy", serv_count: 1, serv_caffeine: 200 }
]

initial_drinks.each do |drink_attrs|
  Drink.find_or_create_by!(**drink_attrs)
end
