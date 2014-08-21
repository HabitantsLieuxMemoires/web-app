require 'factory_girl_rails'
require 'faker'

puts 'DEVELOPMENT USERS'

30.times do
  password = Faker::Internet.password(8)

  FactoryGirl.create(:user,
    nickname: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )
end
