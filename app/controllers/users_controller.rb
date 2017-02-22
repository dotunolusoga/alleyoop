class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # @experience = Experience.find(params[:id])
    @experiences = @user.experiences

    # @canReview = Reservation.where("experience_id = ? AND user_id = ?", @experience.id, @user.id).present? if current_user

    @reviews = @user.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end



end
