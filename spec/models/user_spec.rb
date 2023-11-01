require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryBot.create(:user)
  end

  describe 'associations' do
    it 'should have many reservations' do
      expect(User.reflect_on_association(:reservations).macro).to eq :has_many
    end
  end

  describe 'Validations' do
    it 'it is valid if the name and username are present' do
      expect(@user).to be_valid
    end

    it 'it is not valid without a name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'it is not valid without a username' do
      @user.username = nil
      expect(@user).to_not be_valid
    end

    it 'it is not valid without a unique username' do
      @user2 = User.create(name: 'Mark Brown', username: @user.username)
      expect(@user2).to_not be_valid
    end

    it 'it is not valid if the username has more than 25 characters' do
      @user.username = @user.username * 3
      expect(@user).to_not be_valid
    end
  end
end
