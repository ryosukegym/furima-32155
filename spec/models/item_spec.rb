require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = FactoryBot.build(:user)
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
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'titleがなければ出品できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it 'explanationがなければ出品できない' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'priceがなければ出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300未満だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが9,999,999より大きいと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'priceが全角数字だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number', 'Price 半角数字のみ保存可能であること')
      end

      it 'category_idが1だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'product_condition_idが1だと出品できない' do
        @item.product_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Product condition must be other than 1')
      end

      it 'delivery_fee_idが1だと出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery fee must be other than 1')
      end

      it 'prefectural_idが1だと出品できない' do
        @item.prefectural_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefectural must be other than 0')
      end

      it 'day_to_ship_idが1だと出品できない' do
        @item.day_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Day to ship must be other than 0')
      end
    end
  end
end
