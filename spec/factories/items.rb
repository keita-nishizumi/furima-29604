FactoryBot.define do
  factory :item do
    association :user
    name                   { Faker::Lorem.word }
    information_text       { Faker::Lorem.sentence }
    category_id            { Faker::Number.within(range: 1..10) }
    status_id              { Faker::Number.within(range: 1..6) }
    shipping_fee_status_id { Faker::Number.within(range: 1..2) }
    prefecture_id          { Faker::Number.within(range: 1..47) }
    scheduled_delivery_id  { Faker::Number.within(range: 1..3) }
    sell_price             { Faker::Number.within(range: 300..9_999_999) }
    image                  { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  end
end
