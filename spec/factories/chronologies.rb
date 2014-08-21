# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chronology do
    sequence :title do
      Faker::Number.number(4)
    end
  end
end
