class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.experience
  end

  def destroy
    @review = Review.find(params[:id])
    experience = @review.experience
    @review.destroy

    redirect_to experience
  end

  private
    def review_params
      params.require(:review).permit(:comment, :star, :experience_id)
    end
end
