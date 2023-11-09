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
                 image: { type: :string },
                 experience_fee: { type: :decimal },
                 add_testing_fee: { type: :decimal },
                 reserve_full_table: { type: :decimal },
                 guests: { type: :integer },
                 details: { type: :text }
               },
               required: %w[id name description image experience_fee add_testing_fee reserve_full_table
                            guests]

        let(:id) do
          Experience.create(name: 'Gourmet night', description: 'Incredible mexican spicy dinner for two!!',
                            image: 'urldetest', experience_fee: 25.5, add_testing_fee: 12, reserve_full_table: 50,
                            guests: 2, details: '2 drinks, 1 desert of your choice').id
        end
        run_test!
      end
    end
  end

  path '/api/v1/experiences' do
    post 'Create a new experience' do
      tags 'Experiences'
      consumes 'application/json'
      parameter name: :experience, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          description: { type: :string },
          experience_fee: { type: :decimal },
          add_testing_fee: { type: :decimal },
          reserve_full_table: { type: :decimal },
          guests: { type: :integer },
          image: { type: :string },
          details: { type: :text }
        },
        required: %w[id name description experience_fee add_testing_fee reserve_full_table guests image details]
      }

      response '201', 'experience created' do
        let(:experience) do
          Experience.create(name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela!!',
                            image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20,
                            guests: 2, details: '2 drinks, 1 desert of your choice')
        end
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
                 id: { type: :integer }, name: { type: :string },
                 description: { type: :text }, image: { type: :string },
                 experience_fee: { type: :decimal }, add_testing_fee: { type: :decimal },
                 reserve_full_table: { type: :decimal }, guests: { type: :integer }
               },
               required: %w[id name description image experience_fee add_testing_fee reserve_full_table
                            guests]

        let(:id) do
          Experience.create(
            name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela!!',
            image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20,
            guests: 2, details: '2 drinks, 1 desert of your choice'
          ).id
        end
        run_test!
      end

      response '500', 'Record not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/experiences/{id}' do
    delete 'Delete an experience' do
      tags 'Experiences'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Experience deleted successfully' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 experience_fee: { type: :decimal },
                 add_testing_fee: { type: :decimal },
                 reserve_full_table: { type: :decimal },
                 guests: { type: :integer },
                 image: { type: :string },
                 details: { type: :text }
               },
               required: %w[id name description experience_fee add_testing_fee reserve_full_table guests image details]

        let(:id) do
          Experience.create(id: 1, name: 'Caracas Gourmet',
                            description: 'Enjoy the best cheese cachapas in Venezuela!!', image: 'https:/test.jpg',
                            experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20, guests: 2,
                            details: '2 drinks, 1 desert of your choice').id
        end

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/reservations' do
    get 'Retrieves all Reservations from an User' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :reservation, in: :body

      response '200', 'Reservations found' do
        schema type: :array,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 experience_id: { type: :integer },
                 date: { type: :datetime },
                 city: { type: :string }
               },
               required: %w[id user_id experience_id date city]

        let(:user_id) { '1' }
        let(:reservation) { Reservation.create(:reservation, user_id:) }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/reservations' do
    post 'Creates a Reservation for an User' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          user_id: { type: :integer },
          experience_id: { type: :integer },
          date: { type: :datetime },
          city: { type: :string }
        },
        required: %w[id user_id experience_id date city]
      }

      response '201', 'reservation created' do
        let(:user) { User.create(name: 'Test name', username: 'Teste Username') }
        let(:user_id) { user.id }
        let(:experience) do
          Experience.create(name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela!!',
                            image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20,
                            guests: 2, details: '2 drinks, 1 desert of your choice')
        end
        let(:reservation) do
          { user_id: user.id, experience_id: experience.id, date: '2023-11-02', city: 'Bariloche' }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/reservations/{id}' do
    delete 'Deletes an user Reservation' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Reservations found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 experience_id: { type: :integer },
                 date: { type: :datetime },
                 city: { type: :string }
               },
               required: %w[id user_id experience_id date city]

        let(:experience) do
          Experience.create(name: 'Caracas Gourmet', description: 'Enjoy the best cheese cachapas in Venezuela!!',
                            image: 'https:/test.jpg', experience_fee: 45, add_testing_fee: 10.5, reserve_full_table: 20,
                            guests: 2, details: '2 drinks, 1 desert of your choice')
        end
        let(:user_id) { User.create!(id: 1, name: 'name', username: 'username').id }
        let(:id) do
          Reservation.create!(id: 1, user_id: 1, experience_id: experience.id, date: '2023-11-01', city: 'Tandil').id
        end
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    post 'Creates a new User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          username: { type: :string }
        },
        required: %w[id name username]
      }

      response '201', 'user created' do
        let(:user) { { name: 'Name', username: 'Username' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{username}' do
    get 'Retrieves an specific User' do
      tags 'Users'
      produces 'application/json'
      parameter name: :username, in: :path, type: :string

      response '200', 'User found' do
        schema type: :objetc,
               properties: {
                 exist: { type: :boolean },
                 id: { type: :integer },
                 name: { type: :string },
                 username: { type: :string }
               },
               required: %w[exist id name username]

        let(:username) { User.create(name: 'Name', username: 'UsernameNew').username }
        run_test!
      end

      response '500', 'user not found' do
        let(:username) { 'invalid' }
        run_test!
      end
    end
  end
end
