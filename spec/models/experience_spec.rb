require 'rails_helper'

RSpec.describe Experience, type: :model do
  before :each do
    @experience = FactoryBot.create(:experience)
  end

  describe 'associations' do
    it 'should have many reservations' do
      expect(Experience.reflect_on_association(:reservations).macro).to eq :has_many
    end
  end

  describe "Validations" do
    it "it is valid if all its attributes are present" do
      expect(@experience).to be_valid
    end

    it "it is not valid without a name" do
      @experience.name = nil
      expect(@experience).to_not be_valid
    end

    it "it is not valid without a description" do
      @experience.description = nil
      expect(@experience).to_not be_valid
    end

    it "it is not valid without an experience_fee" do
      @experience.experience_fee = nil
      expect(@experience).to_not be_valid
    end

    it "it is not valid without an add_testing_fee" do
      @experience.add_testing_fee = nil
      expect(@experience).to_not be_valid
    end

    it "it is not valid without a reserve_full_table" do
      @experience.reserve_full_table = nil
      expect(@experience).to_not be_valid
    end

    it "it is not valid without a guests" do
      @experience.guests = nil
      expect(@experience).to_not be_valid
    end

    it "it is not valid if the name has more than 250 characters" do
      @experience.name = "test name" * 40
      expect(@experience).to_not be_valid
    end

    it "it is not valid if the experience_fee is less than or equal to zero" do
      @experience.experience_fee = -400.59
      expect(@experience).to_not be_valid
    end

    it "it is not valid if the add_testing_fee is less than or equal to zero" do
      @experience.experience_fee = -38.20
      expect(@experience).to_not be_valid
    end

    it "it is not valid if the reserve_full_table is less than or equal to zero" do
      @experience.experience_fee = -23.20
      expect(@experience).to_not be_valid
    end

    it "it is not valid if the guests is less than or equal to zero" do
      @experience.guests = -1
      expect(@experience).to_not be_valid
    end

    it "it is not valid if the guests attribute is not an integer" do
      @experience.guests = 12.90
      expect(@experience).to_not be_valid
    end
  end
end
