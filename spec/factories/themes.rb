# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :theme do
    sequence :title do
      Faker::Address.city
    end
  end
end
