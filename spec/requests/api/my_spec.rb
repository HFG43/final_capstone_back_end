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

  path '/api/v1/users/{user_id}/reservations' do

    get 'Retrieves all reservations from an user' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :reservation, in: :body

      response '200', 'Reservations found' do
        schema type: :array,
          properties: {
            id: { type: :integer },
            user_id: { type: :integer},
            experience_id: { type: :integer},
            date: { type: :datetime },
            city: { type: :string }
          },
          required: [ 'id', 'user_id', 'experience_id', 'date', 'city' ]

          let(:user_id) { '1' }
          let(:reservation) { Reservation.create(:reservation, user_id: user_id) }
          run_test!
      end
    end

    post 'Creates a reservation for a user' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
            id: { type: :integer },
            user_id: { type: :integer},
            experience_id: { type: :integer},
            date: { type: :datetime },
            city: { type: :string }
          },
          required: [ 'id', 'user_id', 'experience_id', 'date', 'city' ]
        }

        response '201', 'reservation created' do
          let(:user) { User.create(name: 'Test name', username: 'Teste Username') }
          let(:user_id) { user.id }
          let(:experience) { Experience.create(name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela, on hands of the most creative Chef, Carmen', image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20, guests: 2)}
          let(:reservation) { { user_id: user.id, experience_id: experience.id, date: '2023-11-02', city: 'Bariloche' } }
          run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/reservations/{id}' do

    delete 'Deletes an user reservation' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Reservations found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            user_id: { type: :integer},
            experience_id: { type: :integer},
            date: { type: :datetime },
            city: { type: :string }
          },
          required: [ 'id', 'user_id', 'experience_id', 'date', 'city' ]

          let(:experience) { Experience.create(name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela, on hands of the most creative Chef, Carmen', image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20, guests: 2)}
          let(:user_id) { User.create!(id: 1, name: 'name', username: 'username').id }
          let(:id) { Reservation.create!(id: 1, user_id: 1, experience_id: experience.id, date: '2023-11-01', city: 'Tandil').id }
          run_test!
      end
    end
  end

  path '/api/v1/users' do

    post 'Creates a new user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
            id: { type: :integer },
            name: { type: :string},
            username: { type: :string}            
          },
          required: [ 'id', 'name', 'username' ]
        }

        response '201', 'user created' do
          let(:user) { { name: 'Name', username: 'Username'} }       
          run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do

    get 'Retrieves an specific User' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      
      response '200', 'User found' do
        schema type: :objetc,
          properties: {
            exist: { type: :boolean },
            id: { type: :integer },
            name: { type: :string },
            username: { type: :string }
          },
          required: [ 'exist', 'id', 'name', 'username']
      
        let(:id) { User.create(name: 'Name', username: 'UsernameNew').username }
        run_test!
      end

      response '500', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end  
end