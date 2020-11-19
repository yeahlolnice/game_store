# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.destroy_all
User.destroy_all
Game.destroy_all
Role.destroy_all

user1 = User.new(email: "a@b.com", password: "123456", username: "yeahlolnice", bio: "bloody top bloke")
user1.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "doghax.jpg")), filename: 'doghax.jpg', content_type: 'image/jpg' )
user1.save!

user2 = User.create!(email: "test@test", password: "123456", username: "Gaming_God", bio: "trust me you want me on your team")
user2.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "doge2.jpg")), filename: 'doge2.jpg', content_type: 'image/jpg' )
user2.save!

user3 = User.create!(email: "test2@test", password: "123456", username: "xxKaranxx", bio: "Get the manager")
user3.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "doge.jpg")), filename: 'doge.jpg', content_type: 'image/jpg' )
user3.save!

game1 = Game.new(title: "space invaders", description: "this game is about alians attacking with lazers", approved: "true", avg_rating: "2", price: "2", owner: user1.username)
game1.game_folder.attach(io: File.open(Rails.root.join("app", "assets", "games", "SpaceInvaders.zip")), filename: 'SpaceInavaders.zip', content_type: 'application/zip')
game1.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "spaceinvaders.jpg")), filename: 'spaceinvaders.jpg', content_type: 'image/jpg')
game1.save!()

game2 = Game.new(title: "BomberDudes", description: "this game is about bombing the other dudes", approved: "true", avg_rating: "2", price: "2", owner: user2.username)
game2.game_folder.attach(io: File.open(Rails.root.join("app", "assets", "games", "Donkey_Kong.zip")), filename: 'Donkey_Kong.zip', content_type: 'application/zip')
game2.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "bomberman.jpg")), filename: 'bomberman.jpg', content_type: 'image/jpg')
game2.save!()

game3 = Game.new(title: "Snek.io", description: "yeah good game", approved: "false", avg_rating: "2", price: "2", owner: user2.username)
game3.game_folder.attach(io: File.open(Rails.root.join("app", "assets", "games", "snek.zip")), filename: 'snek.zip', content_type: 'application/zip')
game3.picture.attach(io: File.open(Rails.root.join("app","assets", "images", "snek.jpg")), filename: 'snek.jpg', content_type: 'image/jpg')
game3.save!()

Review.create!(user: user1.username, title: "Love it!", content: "yeah probs the best game", rating: 4, game_id: game1.id )
Review.create!(user: user3.username, title: "hate it!", content: "Not what I expected, I want to talk to the manager", rating: 1, game_id: game1.id )
Review.create!(user: user2.username, title: "pretty chill game!", content: "super chill to play really enjoyed it", rating: 3, game_id: game1.id )
Review.create!(user: user2.username, title: "amazing!", content: "one of the best for sure!", rating: 4.5, game_id: game2.id )
Review.create!(user: user1.username, title: "this will be big", content: "can see with a few updates this game will be great", rating: 3, game_id: game2.id )

Role.create!(name: "admin")
user1.add_role(:admin)

user1.games.push(game1, game2)
user2.games.push(game3, game2)
user3.games.push(game2)

puts "Users created: #{User.count}"
puts "Games created: #{Game.count}"
puts "Reviews created: #{Review.count}"
puts "Roles created: #{Role.count}"
