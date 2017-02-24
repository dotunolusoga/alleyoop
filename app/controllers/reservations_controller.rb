class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_charge_details, except: [:your_outings, :your_reservations]

  def create

    if current_user == @experience.user
      redirect_to @experience, notice: "You can't reserve a spot on your own experience..."
    else
      @reservation = current_user.reservations.create(reservation_params)

      if @reservation
        customer = StripeTool.create_customer(email: params[:stripeEmail],
                                              stripe_token: params[:stripeToken])

        charge = StripeTool.create_charge(customer_id: customer.id,
                                          amount: @amount*100,
                                          description: @description)
      # rescue Stripe::CardError => e
      #   flash[:error] = e.message
        # redirect_to thanks_path
         redirect_to @reservation.experience, notice: "Your reservation has been made"
       end


    end

  end

  def your_outings
    @outings = current_user.reservations
  end

  def your_reservations
    @experiences = current_user.experiences
  end

  def thanks
  end


  private

    def set_charge_details
      @experience = Experience.find(params[:experience_id])
      @amount = @experience.price
      @description = @experience.experience_title
    end

    def reservation_params
      params.require(:reservation).permit(:reservation_date, :price, :total, :experience_id)
    end

end
