require 'factory_girl_rails'
require 'faker'

puts 'DEVELOPMENT FEATURE'

FactoryGirl.create(:feature,
      title:        Faker::Commerce.product_name,
      description:  Faker::Lorem.paragraphs(16, false).join('<br>')
)
