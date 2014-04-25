require 'factory_girl_rails'
require 'faker'

after "development:themes", "development:chronologies" do
  puts 'DEVELOPMENT ARTICLES'

  160.times do
    FactoryGirl.create(:article,
      title:        Faker::Commerce.product_name,
      body:         Faker::Lorem.paragraphs(16, false).join('<br>'),
      theme:        Theme.skip(rand(Theme.count)).first,
      chronology:   Chronology.skip(rand(Chronology.count)).first,
      tags_array:   Faker::Lorem.words(2, true)
    )
  end
end
