# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title         'Test Video'
    url           'https://www.youtube.com/watch?v=cUsOjj8m02o'
    article
  end
end
