# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title    Faker::Commerce.product_name
    body     Faker::Lorem.paragraph(3, false, 4)
    theme
  end

  trait :with_location do
    latitude    Faker::Address.latitude
    longitude   Faker::Address.longitude
  end

end
