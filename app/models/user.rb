class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :last_name, pretence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name, pretence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name_katakana, pretence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_katakana, pretence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday, presence: true

  has_many :items
  has_many :buyers
end
