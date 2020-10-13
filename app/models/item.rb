class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :user
    validates :name, length: { maximum: 40 }
    validates :information_text, length: { maximum: 1000 }
    validates :category_id, numericality: { other_than: 0 }
    validates :status_id, numericality: { other_than: 0 }
    validates :shipping_fee_status_id, numericality: { other_than: 0 }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :scheduled_delivery_id, numericality: { other_than: 0 }
    validates :sell_price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  validates :image, presence: { message: 'をアップロードしてください' }
end
