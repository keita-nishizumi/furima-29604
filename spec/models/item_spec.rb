require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品新規登録' do
    context '新規登録がうまくいくとき' do
      it '全カラムに適切な値が入っていれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      context 'nilのカラムが原因のとき' do
        # はじめにnilにしたいカラムの配列を作成する
        columns = Item.column_names - %w[user_id id created_at updated_at]
        columns.each do |col|
          nihongo = I18n.t "activerecord.attributes.item.#{col}"
          it "#{nihongo}が無ければ登録できない" do
            item_nil_validation(@item, col, nihongo)
          end
        end

        it '出品者が存在しなければ登録できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('出品者を入力してください')
        end

        it '出品画像が無ければ登録できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('出品画像をアップロードしてください')
        end
      end
      context 'nilのカラム以外が原因のとき' do
        # プルダウンリスト値が0（つまり選択なし）の時のエラー
        %w[category_id status_id shipping_fee_status_id prefecture_id scheduled_delivery_id].each do |col|
          nihongo = I18n.t "activerecord.attributes.item.#{col}"
          it "#{nihongo}が選択なし（値が0）では登録できない" do
            not_zero_validation(@item, col, nihongo)
          end
        end
        it '商品名が40文字を超えると登録できない' do
          @item.name = Faker::Lorem.characters(number: 41)
          @item.valid?
          expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
        end
        it '商品の説明が1000文字を超えると登録できない' do
          @item.information_text = Faker::Lorem.characters(number: 1001)
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
        end
        it '価格が整数以外だと登録できない' do
          @item.sell_price = Faker::Lorem.sentence
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は数値で入力してください')
        end
        it '価格が299円以下では登録できない' do
          @item.sell_price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
        end
        it '価格が10,000,000円以上では登録できない' do
          @item.sell_price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
        end
      end
    end
  end
end
