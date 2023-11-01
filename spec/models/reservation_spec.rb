require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before :each do
    @reservation = FactoryBot.create(:reservation)
  end

  describe 'associations' do
    it 'should belong to a user' do
      expect(Reservation.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'should belong to an experience' do
      expect(Reservation.reflect_on_association(:experience).macro).to eq :belongs_to
    end
  end

  describe 'Validations' do
    it 'it is valid if all its attributes are present' do
      expect(@reservation).to be_valid
    end

    it 'it is not valid without a date' do
      @reservation.date = nil
      expect(@reservation).to_not be_valid
    end

    it 'it is not valid without a city' do
      @reservation.city = nil
      expect(@reservation).to_not be_valid
    end
  end
end
