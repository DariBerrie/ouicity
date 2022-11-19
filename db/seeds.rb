# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



puts "Destroying all alerts..."
Alert.destroy_all

puts "Destroying all users..."
User.destroy_all
# Create 5 users with resident role
puts "Creating 5 users with resident role..."

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    role: 0
  )
  # puts "Resident #{User.id} created"
end

# Create 2 users with worker role
puts "Creating 2 users with worker role..."

2.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    role: 1
  )
  # puts "Worker #{User.id} created"
end

# Create 10 alerts
puts "Creating 10 alerts..."

10.times do
  alert = Alert.new(
    title: Faker::Hipster.sentence(word_count: 3),
    description: Faker::Hipster.paragraph(sentence_count: 2),
    category: ["Pollution", "Vandalism", "Transportation", "Noise", "Animals", "Infrastructure"].sample,
    address: ['5 Av. Anatole France, Paris', '16 Villa Gaudelet, Paris', '15 Pl. Vendôme, Paris',
              '35 Rue du Chevalier de la Barre, Paris', '82 Bd de Clichy, Paris'].sample,
    upvotes: rand(1..10),
    status: 0,
    creator_id: User.where(role: 0).sample.id
  )
  alert.save!
end
