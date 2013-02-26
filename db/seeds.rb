# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Creating users"
10.times do |i|
  FactoryGirl.create :user, email: "user#{i}@test.com", password: "123123", password_confirmation: "123123"
end
puts "Login: user0@test.com..user9@test.com"
puts "Password: 123123"

puts

puts "Creating fragments"
20.times do
  fragment = FactoryGirl.build :fragment, code: File.read(__FILE__), author: User.all.sample
  fragment.save!
end
