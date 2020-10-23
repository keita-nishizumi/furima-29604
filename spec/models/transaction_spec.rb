require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    @transaction = FactoryBot.build(:transaction)
  end

  describe '購入手続きをする（注文レコードと住所レコードを新規作成する）' do
    context '購入手続きができるとき ' do
      it 'トークンが生成できており、住所が正しく入力されていれば登録できる' do
        expect(@transaction).to be_valid
      end
    end
    context '購入手続きができないとき' do
      context 'クレジットカード情報が正しく入力されていないとき' do
        it 'トークンが生成されていなければ手続きができない' do
          @transaction.token = nil
          @transaction.valid?
          expect(@transaction.errors.full_messages).to include('クレジットカード情報を正しく入力してください')
        end
      end
      context '属性の欠損が原因のとき' do
        columns = %w[user item postal_code prefecture_id city addresses phone_number]
        columns.each do |col|
          nihongo = Transaction.human_attribute_name(col)
          it "#{nihongo}が無ければ登録できない" do
            not_nil_validation_dynamic(@transaction, col, nihongo)
          end
        end
      end
      context '住所情報が正しく入力されていないとき' do
      end
    end
  end
end
