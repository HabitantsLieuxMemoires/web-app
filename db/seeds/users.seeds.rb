require 'factory_girl_rails'

puts 'DEFAULT USERS'

user = FactoryGirl.create(:user,
  nickname: ENV['USER_NAME'].dup,
  email: ENV['USER_EMAIL'].dup,
  password: ENV['USER_PASSWORD'].dup,
  password_confirmation: ENV['USER_PASSWORD'].dup,
  roles: Hlm::ROLES[:admin].split
)

puts 'user: ' << user.nickname
