# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    description   Faker::Lorem.sentence(8, false, 6)
  end
end
