class PagesController < ApplicationController

  def home
    @experiences = Experience.all
  end

  def search

    if params[:search].present? && params[:search].strip != ""
      session[:local_search] = params[:search]
    end

    arrResult = Array.new

    if session[:local_search] && session[:local_search] != ""
      @experience_address = Experience.where(active: true).near(session[:local_search], 5, order: 'distance')
    else
      @experience_address = Experience.where(active: true).all
    end

    @search = @experience_address.ransack(params[:q])
    @experiences = @search.result

    @arrExperiences = @experiences.to_a

    if (params[:experience_date] && !params[:experience_date].empty?)

      experience_date = Date.parse(params[:experience_date])

      @experiences.each do |experience|
        over_capacity = experience.reservation.where(capacity: 0).limit(1)

        if over_capacity.length > 0
          @arrExperiences.delete(experience)
        end

      end
    end
  end

end
