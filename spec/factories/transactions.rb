FactoryBot.define do
  factory :transaction do
    association :user
    association :item
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code   { "#{rand(100..999)}-#{rand(1000..9999)}" }
    prefecture_id { rand(1..47) }
    city          { Gimei.address.city.kanji }
    addresses     { Gimei.address.town.kanji }
    building      { Faker::Address.street_address }
    phone_number  { rand(10_000_000_000..99_999_999_999) }
  end
end
