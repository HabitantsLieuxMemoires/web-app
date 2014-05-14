require 'factory_girl_rails'
require 'faker'

after "development:users", "development:features", "development:themes", "development:chronologies" do
  puts 'DEVELOPMENT ARTICLES'

  160.times do
    FactoryGirl.create(:article,
      title:        Faker::Commerce.product_name,
      body:         Faker::Lorem.paragraphs(16, false).join('<br>'),
      theme:        Theme.skip(rand(Theme.count)).first,
      chronology:   Chronology.skip(rand(Chronology.count)).first,
      tags_array:   Faker::Lorem.words(2, true),
      author:       User.skip(rand(User.count)).first,
      share_count:  (0..60).to_a.sample,
      created_at:   Date.today-(10000*rand())
    )
  end

  # Features articles
  5.times do
    FactoryGirl.create(:article,
      title:        Faker::Commerce.product_name,
      body:         Faker::Lorem.paragraphs(16, false).join('<br>'),
      theme:        Theme.skip(rand(Theme.count)).first,
      chronology:   Chronology.skip(rand(Chronology.count)).first,
      tags_array:   Faker::Lorem.words(2, true),
      author:       User.skip(rand(User.count)).first,
      share_count:  (0..60).to_a.sample,
      created_at:   Date.today-(10000*rand()),
      feature:      Feature.first
    )
  end

end
