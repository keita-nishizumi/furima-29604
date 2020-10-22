require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '購入する（購入レコードを新規作成する）' do
    context '購入レコードが新規作成できる時' do
      it '全カラムに適切な値が入っており、カード情報が4種全て揃っていれば登録できる' do
        expect(@order).to be_valid
      end
    end
    context '購入レコードが新規作成できない時' do
      it '購入者が無ければ作成できない' do
        @order.user = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('購入者を入力してください')
      end
      it '商品が無ければ作成できない' do
        @order.item = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('商品を入力してください')
      end
    end
  end
end
