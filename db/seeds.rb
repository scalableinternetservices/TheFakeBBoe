# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(username: 'abc', password: '12345678', email: 'abc@gmail.com')
user2 = User.create!(username: 'def', password: '12345678', email: 'bcd@gmail.com')
user3 = User.create!(username: 'user', password: 'password', email: 'user@example.com')

profile1 = Profile.create!(user: user1, name: 'profile1')
feed = UserFeedSubscription.create!(user: user3, profile: profile1)

tag1 = Tag.create!(name: 'Funny')
tag2 = Tag.create!(name: 'WTF')
