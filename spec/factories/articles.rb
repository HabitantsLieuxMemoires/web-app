# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title    Faker::Commerce.product_name
    body     Faker::Lorem.paragraph(3, false, 4)
  end
end
