# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title    Faker::Commerce.product_name
    body     Faker::Lorem.paragraph(3, false, 4)
    theme
    chronology

    factory :article_with_comments do
      ignore do
        comments_count 10
      end

      after(:create) do |article, evaluator|
        create_list(:comment, evaluator.comments_count, article: article)
      end
    end
  end

  trait :with_location do
    location    Faker::Address.latitude << "," << Faker::Address.longitude
  end

end
