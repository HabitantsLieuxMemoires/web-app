# require 'factory_girl_rails'
# require 'faker'
#
# after "development:articles" do
#   puts 'DEVELOPMENT ARTICLE TRACKS'
#
#   660.times do
#     Article.skip(rand(Article.count)).first.update_attributes(
#       :title      => Faker::Commerce.product_name,
#       :author     => User.skip(rand(User.count)).first
#     )
#   end
# end
