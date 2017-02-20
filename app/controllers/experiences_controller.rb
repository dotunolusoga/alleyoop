class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @experiences = current_user.experiences
  end

  def show
    @image_uploads = @experience.image_uploads

    @booked = Reservation.where("experience_id = ? AND user_id = ?", @experience.id, current_user.id).present? if current_user

    @reviews = @experience.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @experience = current_user.experiences.build
    @image_upload = @experience.image_uploads.build
  end

  def create
    @experience = Experience.new
    @experience.user_id = current_user.id
    if @experience.save(validate: false)
      redirect_to experience_build_path(@experience, Experience.form_steps.first), notice: "Begin creating your experience..."

      save_uploads if params[:image_uploads]
    end
    @image_uploads = @experience.image_uploads
  end

  def edit
    if current_user.id == @experience.user.id
      @image_uploads = @experience.image_uploads
    else
      redirect_to root_path, notice: "You're not authorized!"
    end
  end

  def update
    if @experience.update(experience_params)
      redirect_to @experience, notice: "Your changes have been saved"
    else
      render :edit
    end
  end



  private

    def set_experience
      @experience = Experience.find(params[:id])
    end

    def save_uploads
      params[:image_uploads]['image'].each do |image|
        @image_upload = @experience.image_uploads.create!(image: :image)
      end
    end

    def experience_params
      params.require(:experience).permit(:experience_type, :experience_title, :tagline, :summary, :about_host,
                                         :experience_date, :start_time, :end_time,
                                         :location_name, :street, :city, :state, :zipcode,
                                         :drinks, :alcohol, :food, :internet, :parking, :tickets,
                                         :note, :guest_requirement, :capacity, :price, :active,
                                         image_uploads_attributes: [:id, :experience_id, :image])
    end


end
