# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :theme do
    title Faker::Address.city
  end
end
