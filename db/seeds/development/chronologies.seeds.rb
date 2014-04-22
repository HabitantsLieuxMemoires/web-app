require 'factory_girl_rails'
require 'faker'

puts 'DEVELOPMENT CHRONOLOGIES'

8.times do
  FactoryGirl.create(:chronology, title: Faker::Number.number(4))
end
