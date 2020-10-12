class Item < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :user
    validates :name
    validates :information_text
    validates :category_id
    validates :status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :sell_price
  end
end
