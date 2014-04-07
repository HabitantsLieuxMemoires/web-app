# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    nickname              'user.hlm'
    email                 'user@hlm.fr'
    salt                  { 'asdasdastr4325234324sdfds' }
    crypted_password      { Sorcery::CryptoProviders::BCrypt.encrypt('password', 'asdasdastr4325234324sdfds') }
    password              'password'
    password_confirmation 'password'
  end
end
