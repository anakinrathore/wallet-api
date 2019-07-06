include FactoryBot::Syntax::Methods
FactoryBot.define do
  factory :user do
    first_name                { Faker::Name.first_name }
    last_name                 { Faker::Name.last_name }
    email_address             { Faker::Name.first_name + '@gmail.com' }
    phone_number              { Faker::PhoneNumber.subscriber_number(10) }
  end

  factory :wallet do
    balance_in_paise          { SecureRandom.random_number(100000) }
  end
end
