class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @experiences = current_user.experiences
  end

  def show
    @photos = @experience.photos.all
  end

  def new
    @experience = current_user.experiences.build
    @photo = @experience.photos.build
  end

  def create
    @experience = Experience.new
    @experience.user_id = current_user.id
    if @experience.save(validate: false)

      # params[:images]['image'].each do |image|
      #   @photo = @experience.photos.create!(image: image)
      # end
      #
      # @photos = @experience.photos
      redirect_to experience_build_path(@experience, Experience.form_steps.first), notice: "Begin creating your experience..."

    end
  end

  def edit
    if current_user.id == @experience.user.id
      @photos = @experience.photos
    else
      redirect_to root_path, notice: "You're not authorized!"
    end
  end

  def update
    if @experience.update(experience_params)

      # params[:photos]['image'].each do |image|
      #   @photo = @experience.photos.create!(image: image)
      # end

      # if params[:images]
      #   params[:images].each do |image|
      #     @experience.photos.create(image: image)
      #   end
      # end

      redirect_to @experience, notice: "Your changes have been saved"
    else
      render :edit
    end
  end

  private

    def set_experience
      @experience = Experience.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(:experience_type, :experience_title, :tagline, :summary, :about_host,
                                         :experience_date, :start_time, :end_time,
                                         :location_name, :street, :city, :state, :zipcode,
                                         :drinks, :alcohol, :food, :internet, :parking, :tickets,
                                         :note, :guest_requirement, :capacity, :price, :active,
                                         {images: []})
    end


end
