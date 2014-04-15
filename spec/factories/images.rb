# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    title         'Test Image'
    article_image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/test_image.jpg')))
  end

  trait :too_big do
    article_image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/test_image_big.jpg')))
  end
end
