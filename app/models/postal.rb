class Postal < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :order
  belongs_to_active_hash :prefecture

  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  PHONE_NUMBER_REGEX = /\A\d{1,11}\z/.freeze

  with_options presence: true do
    validates :order
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'はハイフン付きで000-0000の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX, message: 'は11桁以内の半角数字で入力してください' }
  end
end
