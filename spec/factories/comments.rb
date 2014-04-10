# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content     Faker::Lorem.sentence(8, false, 6)
  end
end
