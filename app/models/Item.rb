class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :buyer
  has_one_attached :image
  belongs_to :category
  belongs_to :product_condition
  belongs_to :delivery_fee
  belongs_to :prefectural
  belongs_to :day_to_ship

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :product_condition_id
    validates :delivery_fee_id
  end
  with_options numericality: { other_than: 0 } do
    validates :prefectural_id
    validates :day_to_ship_id
  end
  with_options presence: true do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: /\A[0-9]+\z/, message: '半角数字のみ保存可能であること' }
    validates :title
    validates :explanation
    validates :user
    validates :image
  end
end
