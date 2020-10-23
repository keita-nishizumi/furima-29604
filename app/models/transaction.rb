class Transaction
  include ActiveModel::Model
  attr_accessor :user, :item, :token, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number
  # belongs_to_active_hash :prefecture

  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  PHONE_NUMBER_REGEX = /\A\d{1,11}\z/.freeze

  with_options presence: true do
    validates :user
    validates :item
    validates :token, presence: { message: 'を正しく入力してください' }
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'はハイフン付きで000-0000の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX, message: 'は11桁以内の半角数字で入力してください' }
  end

  def save
    order = Order.create(user: user, item: item)
    Postal.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number)
  end
end
