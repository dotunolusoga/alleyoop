class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @experience = Experience.find(params[:experience_id])
    @amount = @experience.price
    @description = @experience.experience_title

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount*100,
      description: @description,
      currency: 'usd'
    )

    if current_user == @experience.user
      redirect_to @experience, notice: "You can't reserve a spot on your own experience..."
    else
      @reservation = current_user.reservations.create(reservation_params)

      redirect_to @reservation.experience, notice: "Your reservation has been made"

    # rescue e
    #   flash[:error] = e.message
    #   redirect_to :back
    end

  end

  def your_outings
    @outings = current_user.reservations
  end

  def your_reservations
    @experiences = current_user.experiences
  end


  private

    def reservation_params
      params.require(:reservation).permit(:reservation_date, :price, :total, :experience_id)
    end

end
