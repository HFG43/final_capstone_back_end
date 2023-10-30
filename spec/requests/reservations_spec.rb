require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/reservations/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /delete' do
    it 'returns http success' do
      get '/reservations/delete'
      expect(response).to have_http_status(:success)
    end
  end
end
