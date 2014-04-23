require 'factory_girl_rails'
require 'faker'

after "development:articles", "development:users" do
  puts 'DEVELOPMENT REPORTS'

  340.times do
    FactoryGirl.create(:report,
      description:  Faker::Lorem.sentence(8, false, 6),
      article:      Article.skip(rand(Article.count)).first,
      user:         User.skip(rand(User.count)).first
    )
  end
end
