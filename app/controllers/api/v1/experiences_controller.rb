class Api::V1::ExperiencesController < ApplicationController
  # GET /experiences
  def index
    experiences = Experience.all
    render json: experiences
  end

  # GET /experiences/:id
  def show
    experience = Experience.find(params[:id])
    render json: experience
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Record not found' }, status: 500
  end

  def create
    json_request = JSON.parse(request.body.read)

    name = json_request['name']
    description = json_request['description']
    experience_fee = json_request['experience_fee']
    add_testing_fee = json_request['add_testing_fee']
    reserve_full_table = json_request['reserve_full_table']
    guests = json_request['guests']
    image = json_request['image']
    details = json_request['details']

    new_experience = Experience.new(name:, description:, experience_fee:, add_testing_fee:,
                                    reserve_full_table:, guests:, image:, details:)

    if new_experience.save
      render json: new_experience, status: :created
    else
      render json: { errors: new_experience.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    experience = Experience.find(params[:id])

    if experience.destroy
      render json: experience
    else
      render json: { errors: experience.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
