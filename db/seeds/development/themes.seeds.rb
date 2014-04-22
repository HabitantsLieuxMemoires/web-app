require 'factory_girl_rails'
require 'faker'

puts 'DEVELOPMENT THEMES'

8.times do
  FactoryGirl.create(:theme, title: Faker::Address.city)
end
