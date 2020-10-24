FactoryBot.define do
  factory :postal do
    association :order
    postal_code   { "#{rand(100..999)}-#{rand(1000..9999)}" }
    prefecture_id { rand(1..47) }
    city          { Gimei.address.city.kanji }
    addresses     { Gimei.address.town.kanji }
    building      { Faker::Address.street_address }
    phone_number  { rand(10_000_000_000..99_999_999_999) }
  end
end
