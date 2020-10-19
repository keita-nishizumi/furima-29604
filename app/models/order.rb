class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :postal
  attr_accessor :card_number, :card_exp_month, :card_exp_year, :card_cvc

  with_options presence: true do
    validates :user
    validates :item
    validates :card_number
    validates :card_exp_month
    validates :card_exp_year
    validates :card_cvc
  end
end
