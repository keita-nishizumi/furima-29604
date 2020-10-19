class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :postal
  attr_accessor :token

  with_options presence: true do
    validates :user
    validates :item
    validates :token
  end
end
