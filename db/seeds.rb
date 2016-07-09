5.times do
  User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end

users = User.all

50.times do
  Wiki.create!(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    user: users.sample,
    private: [true, false].sample
  )
end

puts "#{User.count} users created!"
puts "#{Wiki.count} wiki cerated!"
