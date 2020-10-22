require 'rails_helper'

RSpec.describe Postal, type: :model do
  before do
    @postal = FactoryBot.build(:postal)
  end

  describe '購入する（住所レコードを新規作成する）' do
    context '住所レコードが新規作成' do
      it '全カラムに適切な値が入っていれば登録できる' do
        expect(@postal).to be_valid
      end
    end
    context '住所レコードが新規作成' do
      columns = Postal.column_names - %w[id order_id created_at updated_at building]
      columns.each do |col|
        nihongo = I18n.t "activerecord.attributes.postal.#{col}"
        it "#{nihongo}が無ければ作成できない" do
          not_nil_validation(@postal, col, nihongo)
        end
      end
      it "注文が無ければ作成できない" do
        @postal.order = nil
        @postal.valid?
        expect(@postal.errors.full_messages).to include('注文を入力してください')
      end
      it "郵便番号が000-0000以外の形式では作成できない" do
        @postal.postal_code = "1234-567"
        @postal.valid?
        expect(@postal.errors.full_messages).to include('郵便番号はハイフン付きで000-0000の形式で入力してください')
      end
      it "県が選択なし（値：0）では作成できない" do
        @postal.prefecture_id = 0
        @postal.valid?
        expect(@postal.errors.full_messages).to include('都道府県を選択してください')
      end
      it "電話番号に半角数字以外が含まれると作成できない" do
        @postal.phone_number = "1234567890a"
        @postal.valid?
        expect(@postal.errors.full_messages).to include('電話番号は11桁以内の半角数字で入力してください')
      end
      it "電話番号の桁数が11桁を超えると作成できない" do
        @postal.phone_number = "123456789012"
        @postal.valid?
        expect(@postal.errors.full_messages).to include('電話番号は11桁以内の半角数字で入力してください')
      end
    end
  end
end
