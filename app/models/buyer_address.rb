class BuyerAddress
  include ActiveModel::Model
  attr_accessor :user_id,:item_id,:postal_code,:prefectural_id,:city,:street,:building,:tel,:token

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :prefectural_id,numericality: {other_than: 0 }
    validates :postal_code,format:{with: /\A\d{3}[-]\d{4}\z/}
    validates :city
    validates :street
    validates :tel, format: { with: /\A\d{11}\z/}
    validates :token
  end
  def save
    # 各テーブルにデータを保存する処理を書く
    buyer = Buyer.create(user_id: user_id,item_id: item_id)

    ShippingAddress.create(prefectural_id: prefectural_id,postal_code: postal_code,city: city, street: street, tel: tel,buyer_id: buyer.id)
  end
end