class Experience < ApplicationRecord
  # Associations.
  has_many :reservations, class_name: 'Reservation', foreign_key: 'experience_id', dependent: :destroy

  # Validations.
  validates :name, :description, :image, :experience_fee, :add_testing_fee, :reserve_full_table, :guests, presence: true
  validates :name, length: { maximum: 250 }
  validates :experience_fee, :add_testing_fee, :reserve_full_table, comparison: { greater_than: 0 }
  validates :guests, comparison: { greater_than: 0 }, numericality: { only_integer: true }
end
