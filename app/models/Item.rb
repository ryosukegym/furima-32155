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

  validates :category_id, numericality: { other_than: 1 }
  validates :product_condition_id, numericality: { other_than: 1 }
  validates :delivery_fee_id, numericality: { other_than: 1 }
  validates :prefectural_id, numericality: { other_than: 0 }
  validates :day_to_ship_id, numericality: { other_than: 0 }

  with_options presence: true do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: /\A[0-9]+\z/, message: '半角数字のみ保存可能であること' }
    validates :title
    validates :explanation
    #  numericality: {
    #   greater_than_or_equal_to: 300,
    #   less_than_or_equal_to: 9_999_999,
    #   message: 'Price Out of setting range'
    # }
    # priceの範囲を指定
    validates :user
    validates :image
  end
  # 空だとデータが送られない
  # imageは必須
end
