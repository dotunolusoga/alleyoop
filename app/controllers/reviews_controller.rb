class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.user
  end

  def destroy
    @review = Review.find(params[:id])
    user = @review.user
    @review.destroy

    redirect_to user
  end

  private
    def review_params
      params.require(:review).permit(:comment, :star, :experience_id)
    end
end
