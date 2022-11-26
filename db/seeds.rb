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
puts "Creating 5 alerts..."

alert = Alert.new(
  title: "Car parked in bike lane",
  description: "There are always cars parked in this bike lane that leads to the school.
                It's very dangerous for cyclists.",
  category: "Transportation",
  address: '5 Av. Anatole France, Paris',
  upvotes: rand(1..10),
  status: 0,
  creator_id: User.where(role: 0).sample.id
)
alert.photos.attach(io: File.open(File.join(Rails.root, 'app/assets/images/carparked.png')),
                    filename: "alert#{alert.id}.png")
alert.save!

alert = Alert.new(
  title: "Trash pile on the side of the road",
  description: "Someone dumped their trash bags in the street where there's no can or bin.
                It's really starting to smell.",
  category: "Pollution",
  address: '16 Villa Gaudelet, Paris',
  upvotes: rand(1..10),
  status: 0,
  creator_id: User.where(role: 0).sample.id
)
alert.photos.attach(io: File.open(File.join(Rails.root, 'app/assets/images/garbagebags.png')),
                    filename: "alert#{alert.id}.png")
alert.save!

alert = Alert.new(
  title: "Stray dog roaming streets",
  description: "A brown labrador-type dog has been hanging around in this neighborhood and
                doesn't seem to have an owner. Not aggressive. Often at Parc Monceau",
  category: "Animals",
  address: '15 Pl. Vendôme, Paris',
  upvotes: rand(1..10),
  status: 0,
  creator_id: User.where(role: 0).sample.id
)
alert.photos.attach(io: File.open(File.join(Rails.root, 'app/assets/images/straydog.png')),
                    filename: "alert#{alert.id}.png")
alert.save!


alert = Alert.new(
  title: "Many beer bottles & cans left on ground",
  description: "After each football match, beer bottles are left all around the lawn in front of the post office",
  category: "Pollution",
  address: '35 Rue du Chevalier de la Barre, Paris',
  upvotes: rand(1..10),
  status: 0,
  creator_id: User.where(role: 0).sample.id
)
alert.photos.attach(io: File.open(File.join(Rails.root, 'app/assets/images/beerbottles.png')),
                    filename: "alert#{alert.id}.png")
alert.save!

alert = Alert.new(
  title: "Graffiti on park entrance wall",
  description: "Woke up to new graffiti on the park wall. It's horribly ugly.",
  category: "Vandalism",
  address: '82 Bd de Clichy, Paris',
  upvotes: rand(1..10),
  status: 0,
  creator_id: User.where(role: 0).sample.id
)
alert.photos.attach(io: File.open(File.join(Rails.root, 'app/assets/images/graffiti.png')),
                    filename: "alert#{alert.id}.png")

alert.save!
