# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feature do
    title         Faker::Commerce.product_name
    description   Faker::Lorem.paragraphs(16, false).join('<br>')
  end
end
