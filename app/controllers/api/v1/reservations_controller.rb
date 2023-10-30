class ReservationsController < ApplicationController
  def index
    reservations = Reservation.all
    render json: reservations  
  end

  def delete
    reservation = Reservation.find(params[:id])
    reservation.destroy
    render json: reservation
  end
end
