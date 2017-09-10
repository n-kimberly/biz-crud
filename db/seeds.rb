# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'random_data'

5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

users = User.all

admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

mod = User.create!(
  name:     'Mod User',
  email:    'mod@example.com',
  password: 'helloworld',
  role:     'mod'
)

member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)

15.times do |i|
  i = i.to_s
  Topic.create!(
    name: 'Topic ' + i,
    description: RandomData.random_paragraph
  )
end

topics = Topic.all

50.times do |i|
  i = i.to_s
  post = Post.create!(
    topic:  topics.sample,
    title: 'Post ' + i,
    body: RandomData.random_paragraph,
    user: users.sample
  )
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)

  rand(1..5).times {
    post.votes.create!(
      value: [-1, 1].sample,
      user: users.sample
    )
  }
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph,
    price: RandomData.random_number
  )
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false
  )
end

posts = Post.all

100.times do |i|
  i = i.to_s
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: 'Comment ' + i + ' : ' + RandomData.random_paragraph
  )
end

Post.find_or_create_by(title: "Unique Title", body: "Unique Body")

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Vote.count} votes created"
