class ReservationsController < ApplicationController
  before_action :authenticate_user

  def create
    @reservation = current_user.reservations.create(reservation_params)

    redirect_to @reservation.experience
  end


  private

  def reservation_params
    params.require(:reservation).permit(:reservation_date, :price, :total, :experience_id)
  end

end
