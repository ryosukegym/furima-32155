class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :last_name, pretence: true
  validates :first_name, pretence: true
  validates :last_name_katakana, pretence: true
  validates :first_name_katakana, pretence: true
  validates :birthday, presence: true

  has_many :items
  has_many :buyers

end
