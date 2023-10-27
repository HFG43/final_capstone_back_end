class User < ApplicationRecord
  has_many :reservations
  has_many :experiences

  validates :name, presence: true
  validates :username, presence: true, length: { maximum: 25 }, uniqueness: true
end
