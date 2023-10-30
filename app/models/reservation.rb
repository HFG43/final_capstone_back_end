class Reservation < ApplicationRecord
    belong_to :user, class_name 'User', foreign_key: 'users_id'
    belong_to :experience, class_name 'Experience', foreign_key: 'experiences_id'
end
