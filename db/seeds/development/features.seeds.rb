require 'factory_girl_rails'
require 'faker'

puts 'DEVELOPMENT FEATURE'

f = FactoryGirl.create(:feature,
      title:        Faker::Commerce.product_name,
      description:  Faker::Lorem.paragraphs(4, false).join('<br>')
)

5.times do
  f.articles << Article.skip(rand(Article.count)).first
  f.save!
end
