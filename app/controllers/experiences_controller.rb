class ExperiencesController < ApplicationController
  before_action set_experience, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @experiences = current_user.experiences
  end

  def show
  end

  def new
    @experience = current_user.experience.build
  end

  def create
    @experience = current_user.experience.build(experience_rarams)

    if @experience.save
      redirect_to @experience, notice: "Experience created!"
    else
      render :new
    end

  end

  def edit
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

    def experience_params
      params.require(:experience).permit(:experience_type, :experience_title, :tagline, :summary, :about_host,
                                         :experience_date, :start_time, :end_time,
                                         :location_name, :street, :city, :state, :zipcode,
                                         :drinks, :alcohol, :food, :internet, :parking, :tickets,
                                         :note, :guest_requirement, :capacity, :price, :active)
    end


end
