class Experience::BuildController < ApplicationController
  include Wicked::Wizard

  steps *Experience.form_steps

  def show
    @experience = Experience.find(params[:experience_id])
    render_wizard
  end

  def update
    @experience = Experience.find(params[:experience_id])
    @experience.update(experience_params(step))
    render_wizard @experience
  end


  private

  def experience_params(step)
    permitted_attributes = case step
                           when "details"
                             [:experience_type, :experience_title, :tagline, :summary, :about_host]
                           when "photos"
                             [:images]
                           when "location"
                             [:location_name, :street, :city, :state, :zipcode]
                           when "time"
                             [:experience_date, :start_time, :end_time]
                           when "amenities"
                             [:drinks, :alcohol, :food, :internet, :parking, :tickets]
                           when "notes"
                             [:note, :guest_requirement]
                           when "finishing_touches"
                             [:capacity, :price]
                           end

    params.require(:experience).permit(permitted_attributes).merge(form_step: step)
  end


end
