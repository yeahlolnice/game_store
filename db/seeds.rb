# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Game.destroy_all

user = User.create!(email: "a@b.com", password: "123456", username: "yeahlolnice")
User.create!(email: "foo1@bar", password: "123456", username: "foo1")

game1 = Game.new(title: "space invaders", description: "yeah good game", approved: "true", avg_rating: "2", price: "2", owner: user.username)
game1.game_folder.attach(io: File.open(Rails.root.join("app", "assets", "games", "snek.zip")), filename: 'snek.zip', content_type: 'application/zip')
game1.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "bomberman.jpg")), filename: 'bomberman.jpg', content_type: 'application/zip')
game1.save!()
