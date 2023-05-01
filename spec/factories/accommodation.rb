FactoryBot.define do
  factory :accommodation do
    name { Faker::Name.female_first_name }
    description { Faker::Quotes::Chiquito.expression }
    address_owner { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    email { 'partner225@test.com' }
    kind { Faker::House.room }
    reg_code { Faker::IDNumber.spanish_citizen_number }
    person { Faker::Name.last_name }

    association :user, factory: :user
  end
end
