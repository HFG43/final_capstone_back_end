class Reservation < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'users_id'
  belongs_to :experience, class_name: 'Experience', foreign_key: 'experiences_id'

  validates :date, :city, presence: true
end
