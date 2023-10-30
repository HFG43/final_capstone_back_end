class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.find_by(user_id: params[:user_id])
    render json: reservations
  end

  def delete
    reservation = Reservation.find(params[:id])
    reservation.destroy
    render json: reservation
  end
end
