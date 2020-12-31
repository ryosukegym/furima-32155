require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品成功' do
      it 'image,title,explanation,price,category_id,product_condition_id,delivery_fee_id,prefectural_id,day_to_ship_idがあれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品失敗' do
      it 'imageがなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end

      it 'titleがなければ出品できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'explanationがなければ出品できない' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください"])
      end

      it 'priceがなければ出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください", "販売価格は数値で入力してください", "販売価格半角数字のみ保存可能であること")
      end

      it 'priceが300未満だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end

      it 'price半角英数混合では登録できないこと' do
        @item.price = "t12t"
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it 'price半角英語だけでは登録できないこと' do
        @item.price = "test"
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it 'priceが9,999,999より大きいと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end

      it 'priceが全角数字だと出品できない' do
        @item.price = '１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it 'category_idが1だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
      end

      it 'product_condition_idが1だと出品できない' do
        @item.product_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
      end

      it 'delivery_fee_idが1だと出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include(["Delivery feeは1以外の値にしてください")
      end

      it 'prefectural_idが1だと出品できない' do
        @item.prefectural_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は0以外の値にしてください")
      end

      it 'day_to_ship_idが1だと出品できない' do
        @item.day_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は0以外の値にしてください")
      end
    end
  end
end
