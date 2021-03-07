# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

# userscsv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
# csv = CSV.parse(userscsv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#     new_user = User.create!(username: row['username'], password: row['password'], email: row['email'])
#     puts new_user.id
# end
# puts "Finished users"
# profiles_csv_text = File.read(Rails.root.join('lib', 'seeds', 'profiles.csv'))
# p_csv = CSV.parse(profiles_csv_text, :headers => true, :encoding => 'ISO-8859-1')
# p_csv.each do |row|
#     puts "USERID", row['name']
#     connected_user = User.find(row['user_id'])
# 
#     puts connected_user
#     new_profile = Profile.create!(user: connected_user, name: row['name'], age: 21, occupation: "job", location: "place", bio: "hi")
#     puts new_profile
# end

user1 = User.create!(username: 'abc', password: '12345678', email: 'abc@gmail.com')
user2 = User.create!(username: 'def', password: '12345678', email: 'bcd@gmail.com')
user3 = User.create!(username: 'user', password: 'password', email: 'user@example.com')

profile1 = Profile.create!(user: user1, name: 'EdgyMemelord12', age: 12)
profile2 = Profile.create!(user: user1, name: 'Emomemer', age: 3.14159)
profile3 = Profile.create!(user: user2, name: 'Abed', age: 1002)
profile4 = Profile.create!(user: user3, name: 'Hello', age: 10_000_000)
profile5 = Profile.create!(user: user3, name: 'the_fake_bboe', age: 1)

feed1 = UserFeedSubscription.create!(user: user2, profile: profile1)
feed2 = UserFeedSubscription.create!(user: user3, profile: profile1)

tag1 = Tag.create!(name: 'Funny')
tag2 = Tag.create!(name: 'WTF')
tag3 = Tag.create!(name: "Cats that look surprisingly similar to the way most cats don't.")
