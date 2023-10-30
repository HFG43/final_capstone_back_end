class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.find_by(users_id: params[:user_id])
    render json: reservations
  end

  def create
    json_request = JSON.parse(request.body.read)

    user_id = json_request['user_id']
    experience_id = json_request['experience_id']
    
    user = User.find(user_id)
    experience = Experience.find(experience_id)
    date = json_request['date']
    city = json_request['city']

    new_reservation = Reservation.new(user:, experience:, date:, city:)

    if new_reservation.save
      render json: new_reservation, status: :created
    else
      render json: { errors: new_reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    render json: reservation
  end
end
