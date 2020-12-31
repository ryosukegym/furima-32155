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
        expect(@buyer_address.errors.full_messages).to include("Prefecturalを入力してください", "Prefecturalは数値で入力してください")
      end

      it '・prefectural_idが0では購入できない' do
        @buyer_address.prefectural_id = 0
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Prefecturalは0以外の値にしてください")
      end
  

      it 'postal_codeがなければ購入できない' do
        @buyer_address.postal_code = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal codeを入力してください", "Postal codeは不正な値です")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buyer_address.postal_code = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal codeは不正な値です")
      end

      it 'cityがなければ購入できない' do
        @buyer_address.city = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Cityを入力してください")
      end

      it 'streetがなければ購入できない' do
        @buyer_address.street = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Streetを入力してください")
      end

      it 'telがなければ購入できない' do
        @buyer_address.tel = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Telを入力してください")
      end
      it 'telが12桁以上では購入できない' do
        @buyer_address.tel = '090123412341'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Telは不正な値です")
      end
      it 'telが英数混合では購入できない' do
        @buyer_address.tel = 'a90123412341'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Telは不正な値です")
      end
      it "tokenが空では登録できないこと" do
        @buyer_address.token = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Tokenを入力してください")
      end
      it 'user_idが空では購入できないこと' do
        @buyer_address.postal_code = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal codeを入力してください", "Postal codeは不正な値です")
      end

      it 'item_idが空では購入できないこと' do
        @buyer_address.postal_code = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal codeを入力してください", "Postal codeは不正な値です")
      end
    end
  end
end
