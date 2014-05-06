# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feature do
    title         Faker::Commerce.product_name
    description   Faker::Lorem.paragraphs(16, false).join('<br>')

    factory :feature_with_articles do
      ignore do
        articles_count 5
      end

      after(:create) do |feature, evaluator|
        create_list(:article, evaluator.articles_count, feature: feature)
      end
    end
  end
end
