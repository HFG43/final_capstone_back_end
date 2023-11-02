require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/v1/users/:username' do
    context 'with valid username' do
      before do
        user = FactoryBot.create(:user)
        get "/api/v1/users/#{user.username}"
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end

      it "responds with 'exist' equal to true - the user exists" do
        expected_result = parse_json({ exist: true }.to_json)

        expect(response_body).to include(expected_result)
      end
    end

    context 'with invalid username' do
      before do
        user = FactoryBot.create(:user)
        get "/api/v1/users/#{user.username}_test"
      end

      it "responds with 'exist' equal to false - the user does not exist" do
        expected_result = parse_json({ exist: false }.to_json)

        expect(response_body).to eq(expected_result)
      end
    end
  end

  describe 'POST /api/v1/users/create' do
    context 'with valid parameters' do
      let(:valid_user_data) { { name: 'James', username: 'rubyOnRailsDev' } }

      it 'creates a new user and responds with a success status: 201' do
        post '/api/v1/users', params: valid_user_data.to_json
        expect(response).to have_http_status(:created)

        new_user = User.find_by(username: 'rubyOnRailsDev')
        expect(new_user).to be_present
        expect(new_user.name).to eq('James')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_user_data) { { name: 'Lucas', username: '' } }

      it 'responds with an unprocessable entity status: 422' do
        post '/api/v1/users', params: invalid_user_data.to_json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
