# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'random_data'
require 'faker'
include Faker

5.times do
  User.create!(
    name: Name.unique.name,
    email: Internet.email,
    password: 'password'
  )
end

users = User.all

admin = User.create!(
  name: "Suited Admin",
  email: 'suited-admin@example.com',
  password: 'password',
  role: 'admin'
)

mod = User.create!(
  name: "Executive Moderator",
  email: 'executive-moderator@example.com',
  password: 'password',
  role: 'mod'
)

member = User.create!(
  name: "Standard Bro",
  email: 'standard-bro@example.com',
  password: 'password',
  role: 'member'
)

10.times do |i|
  Config.random = Random.new(i)
  bz = Company.buzzword
  Topic.create!(
    name: bz.capitalize,
    description: "Posts pertaining to #{bz} things"
  )
end

topics = Topic.all

50.times do |i|
  post = Post.create!(
    topic:  topics.sample,
    title: Company.bs.capitalize,
    body: "#{HowIMetYourMother.catch_phrase}! #{HitchhikersGuideToTheGalaxy.quote}.. #{HitchhikersGuideToTheGalaxy.quote}",
    user: users.sample
  )
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)

  rand(1..50).times {
    post.votes.create!(
      value: [-1, 1].sample,
      user: users.sample
    )
  }
end

posts = Post.all

200.times do |i|
  i = i.to_s
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: VentureBros.quote
  )
end

Post.find_or_create_by(title: "Unique Title", body: "Unique Body")

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
