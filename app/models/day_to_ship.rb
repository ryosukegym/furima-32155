class DayToShip < ActiveHash::Base
  self.data = [
    { id: 0, data: '---' },
    { id: 1, data: '1~2日で発送' },
    { id: 2, data: '2~3日で発送' },
    { id: 3, data: '4~7日で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
end
