# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
99.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:  username,
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at:          Time.now)
end

category = Category.create!(name: "Test")
id = category.id

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.word()
  users.each { |user| user.microposts.create!(content: content, title: title, category_id: id ) }
end
=end

User.create!(username:  "a.marfoglia",
             email: "a.marfoglia@hotmail.it",
             password:              "londra03",
             password_confirmation: "londra03",
             confirmed_at:          Time.now)
