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

    factory :article_with_videos do
      ignore do
        videos_count 3
      end

      after(:create) do |article, evaluator|
        create_list(:video, evaluator.videos_count, article: article)
      end
    end

    after(:create) { |a| Article.searchkick_index.refresh }
  end

  trait :with_location do
    location    Faker::Address.latitude << "," << Faker::Address.longitude
  end

end
