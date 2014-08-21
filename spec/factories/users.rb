# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:nickname)   { Faker::Name.name }
    sequence(:email)      { Faker::Internet.email }
    salt                  { 'asdasdastr4325234324sdfds' }
    crypted_password      { Sorcery::CryptoProviders::BCrypt.encrypt('password', 'asdasdastr4325234324sdfds') }
    password              'password'
    password_confirmation 'password'
  end

  trait :admin do
    roles                 Hlm::ROLES[:admin].split
  end
end
