class Item
  include ActiveModel::Model
  validates :name, length: { maximum: 6 }
  attr_accessor :name
end