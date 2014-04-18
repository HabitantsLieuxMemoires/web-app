require 'factory_girl_rails'
require 'faker'

after "development:articles" do
  puts 'DEVELOPMENT COMMENTS'

  280.times do
    FactoryGirl.create(:comment,
      content:      Faker::Lorem.paragraph(4, true, 2),
      article:      Article.skip(rand(Article.count)).first,
      created_at:   Date.today-(10000*rand())
    )
  end
end

