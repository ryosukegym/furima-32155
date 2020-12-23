require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item,user_id: user.id)
    sleep 0.5
    @buyer_address = FactoryBot.build(:buyer_address, user_id: user.id,item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品成功' do
      it 'prefetural_id,postal_code,city,street,tel' do
        expect(@buyer_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @buyer_address.building = nil
        expect(@buyer_address).to be_valid
      end
    end

    context '購入失敗' do
      it 'prefectural_idがなければ購入できない' do
        @buyer_address.prefectural_id = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Prefectural can't be blank")
      end
  

      it 'postal_codeがなければ購入できない' do
        @buyer_address.postal_code = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buyer_address.postal_code = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal code is invalid")
      end

      it 'cityがなければ購入できない' do
        @buyer_address.city = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("City can't be blank")
      end

      it 'streetがなければ購入できない' do
        @buyer_address.street = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Street can't be blank")
      end

      it 'telがなければ購入できない' do
        @buyer_address.tel = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Tel can't be blank")
      end
      it 'telが12桁以上では購入できない' do
        @buyer_address.tel = '090123412341'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Tel is invalid")
      end
      it 'telが英数混合では購入できない' do
        @buyer_address.tel = 'a90123412341'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Tel is invalid")
      end
      it "tokenが空では登録できないこと" do
        @buyer_address.token = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
