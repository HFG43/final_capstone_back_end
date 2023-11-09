require 'rails_helper'

RSpec.describe 'Experiences', type: :request do
  describe 'GET /api/v1/experiences' do
    before do
      @experiences = FactoryBot.create_list(:experience, 8)
      get '/api/v1/experiences'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the list of all experiences' do
      expected_result = parse_json(@experiences.to_json)

      expect(response_body.size).to eq(8)
      expect(response_body).to eq(expected_result)
    end
  end

  describe 'GET /api/v1/experiences/:id' do
    context 'with existing id' do
      before do
        @experiences = FactoryBot.create_list(:experience, 2)
        get "/api/v1/experiences/#{@experiences[1].id}"
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with the data of the experience' do
        expected_result = parse_json(@experiences[1].to_json)

        expect(response_body).to eq(expected_result)
      end
    end

    context 'with non-existent id' do
      before do
        experience = FactoryBot.create(:experience)
        get "/api/v1/experiences/#{experience.id}0"
      end

      it 'responds with status: 500' do
        expect(response).to have_http_status(500)
      end

      it "responds with an error message: 'Record not found'" do
        expected_result = parse_json({ error: 'Record not found' }.to_json)
        expect(response_body).to eq(expected_result)
      end
    end
  end

  describe 'POST /api/v1/experiences' do
    context 'Create a valid experience' do
      let(:valid_experience) do
        {
          name: 'Thibon Coffee',
          description: 'A remarkable coffee with a lot of history.',
          experience_fee: 34.57,
          add_testing_fee: 5.18,
          reserve_full_table: 6.91,
          guests: 2,
          image: 'https://i.postimg.cc/HkdXmFRb/cafe-thibon.jpg',
          details: '2 coffees of your choice; 1 toasted sirloin and cheddar'
        }
      end

      it 'respond with a create status' do
        post '/api/v1/experiences', params: valid_experience.to_json
        expect(response).to have_http_status(:created)
      end
    end

    context 'Create a experience with invalid parameters' do
      let(:invalid_experience) do
        {
          name: 'Thibon Coffee',
          description: '',
          experience_fee: 34.57,
          add_testing_fee: 5.18,
          reserve_full_table: 6.91,
          guests: 2,
          image: 'https://i.postimg.cc/HkdXmFRb/cafe-thibon.jpg',
          details: '2 coffees of your choice; 1 toasted sirloin and cheddar'
        }
      end

      it 'respond with a create status' do
        post '/api/v1/experiences', params: invalid_experience.to_json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/experiences/:id' do
    before do
      @experience = FactoryBot.create(:experience)
    end

    it 'responds with ok estatus' do
      delete "/api/v1/experiences/#{@experience.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
