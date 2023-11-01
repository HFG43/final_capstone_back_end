require 'swagger_helper'

describe 'Book an Appointment API' do
  
  path '/api/v1/experiences' do

    get 'Retrieves all Experiences' do
      tags 'Experiences'
      produces 'application/json'

      response '200', 'Experiences found' do
        schema type: :array,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :text },
            image: { type: :string},
            experience_fee: { type: :decimal },
            add_testing_fee: { type: :decimal },
            reserve_full_table: { type: :decimal },
            guests: { type: :integer }
          },
          required: [ 'id', 'name', 'description', 'image', 'experience_fee', 'add_testing_fee', 'reserve_full_table', 'guests']

          let(:id) { Experience.create(name: 'Gourmet night', description: 'Incredible spicy dinner for two, where you will savor the delights of Mexican culture.', image: 'urldetest', experience_fee: 25.5, add_testing_fee: 12, reserve_full_table: 50, guests: 2).id }
          run_test!
      end
    end
  end  

  path '/api/v1/experiences/{id}' do

    get 'Retrieves an specific Experience' do
      tags 'Experiences'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      
      response '200', 'Experience found' do
        schema type: :objetc,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :text },
            image: { type: :string},
            experience_fee: { type: :decimal },
            add_testing_fee: { type: :decimal },
            reserve_full_table: { type: :decimal },
            guests: { type: :integer }
          },
          required: [ 'id', 'name', 'description', 'image', 'experience_fee', 'add_testing_fee', 'reserve_full_table', 'guests']
      
        let(:id) { Experience.create(name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela, on hands of the most creative Chef, Carmen', image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20, guests: 2).id }
        run_test!
      end

      response '500', 'Record not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end
  end
end