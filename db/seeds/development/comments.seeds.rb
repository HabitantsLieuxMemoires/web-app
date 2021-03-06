require 'factory_girl_rails'
require 'faker'

after "development:articles", "development:users" do
  puts 'DEVELOPMENT COMMENTS'

  840.times do
    FactoryGirl.create(:comment,
      content:      Faker::Lorem.paragraph(4, true, 2),
      article:      Article.skip(rand(Article.count)).first,
      user:         User.skip(rand(User.count)).first,
      created_at:   Date.today-(10000*rand())
    )
  end
end

