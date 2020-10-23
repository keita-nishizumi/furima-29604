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
      context '住所情報が正しく入力されていないとき' do
        it '郵便番号にハイフンが無ければ登録できない' do
          @transaction.postal_code = '0001234'
          @transaction.valid?
          expect(@transaction.errors.full_messages).to include('郵便番号はハイフン付きで000-0000の形式で入力してください')
        end
        it '都道府県が選択なし（値：0）では登録できない' do
          @transaction.prefecture_id = 0
          @transaction.valid?
          expect(@transaction.errors.full_messages).to include('都道府県を選択してください')
        end
        it '電話番号が12桁以上では登録できない' do
          @transaction.phone_number = '123456789012'
          @transaction.valid?
          expect(@transaction.errors.full_messages).to include('電話番号は11桁以内の半角数字で入力してください')
        end
        it '電話番号に半角数字以外が含まれると登録できない' do
          @transaction.phone_number = '1234567890１'
          @transaction.valid?
          expect(@transaction.errors.full_messages).to include('電話番号は11桁以内の半角数字で入力してください')
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
    end
  end
end
