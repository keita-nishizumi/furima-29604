class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #全カラム必須とする
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :first_name
    validates :first_name_kana
    validates :last_name
    validates :last_name_kana
    validates :birth_date
  end

  #ユーザー情報のvalidation
  EMAIL_REGEX = /.+@.+/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6}+\z/i.freeze

  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX, message: 'には@を含めて設定してください'
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  #本人情報確認のvalidation
  REALNAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/
  KANA_REGEX = /\A[ァ-ン]+\z/

  with_options format: { with: REALNAME_REGEX, message: '全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options format: { with: KANA_REGEX, message: '全角カタカナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end
end