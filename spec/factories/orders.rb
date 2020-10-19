FactoryBot.define do
  factory :order do
    association :user
    association :item
    card_number    { "4242424242424242" }
    card_exp_month { "3" }
    card_exp_year  { "33" }
    card_cvc       { "123" }
  end
end
