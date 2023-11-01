require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  describe 'GET /api/v1/users/:user_id/reservations' do
    before do
      user = FactoryBot.create(:user)
      @reservations = FactoryBot.create_list(:reservation, 5, user:)
      get "/api/v1/users/#{user.id}/reservations"
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the list of all reservations by a given user' do
      expected_result = parse_json(@reservations.to_json)
      expect(response_body.size).to eq(5)
      expect(response_body).to eq(expected_result)
    end
  end

  describe 'POST /api/v1/users/:user_id/reservations' do
    before do
      @user = FactoryBot.create(:user)
      @experience = FactoryBot.create(:experience)
    end

    context 'with valid parameters' do
      let(:valid_reservation_data) do
        { user_id: @user.id, experience_id: @experience.id, date: '2023-10-31', city: 'New York' }
      end

      it 'creates a new reservation and responds with a success status: 201' do
        post "/api/v1/users/#{@user.id}/reservations", params: valid_reservation_data.to_json
        expect(response).to have_http_status(:created)

        new_reservation = Reservation.find(response_body['id'])
        expect(new_reservation).to be_present
        expect(new_reservation.user).to eq(@user)
        expect(new_reservation.experience).to eq(@experience)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_reservation_data) { { user_id: @user.id, experience_id: @experience.id, date: '', city: '' } }

      it 'responds with an unprocessable entity status: 422' do
        post "/api/v1/users/#{@user.id}/reservations", params: invalid_reservation_data.to_json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/users/:user_id/reservations/:id' do
    before do
      user = FactoryBot.create(:user)
      reservations = FactoryBot.create_list(:reservation, 2, user:)
      @deleted_reservation = reservations[0]
      delete "/api/v1/users/#{user.id}/reservations/#{@deleted_reservation.id}"
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with the deleted reservation data' do
      expected_result = parse_json(@deleted_reservation.to_json)
      expect(response_body).to eq(expected_result)
    end

    it 'should change the total number of reservations' do
      expect(Reservation.all.count).to eq(1)
    end
  end
end
