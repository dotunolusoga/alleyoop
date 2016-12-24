class Experience < ActiveRecord::Base
  belongs_to :user

  cattr_accessor :form_steps do
    %w(details location time amenities notes finishing_touches)
  end

  attr_accessor :form_step

  validates :experience_type, :experience_title, :tagline,
            :summary, :about_host, presence: true, if: -> { required_for_step?(:details) }

  validates :experience_date, :start_time, :end_time,
            presence: true, if: -> { required_for_step?(:time) }

  validates :location_name, :street, :city, :state,
            :zipcode, presence: true, presence: true, if: -> { required_for_step?(:location) }

  validates :capacity, :price, presence: true, if: -> { required_for_step?(:finishing_touches) }


  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

  EXPERIENCE_TYPE = [
    ['Arts & Design', 'Arts_Design'],
    ['Fashion', 'Fashion'],
    ['Sports', 'Sports'],
    ['Wellness', 'Wellness'],
    ['Nature', 'Nature'],
    ['Food & Drink', 'Food_Drink'],
    ['Lifestyle', 'Lifestyle'],
    ['History', 'History'],
    ['Music', 'Music'],
    ['Business', 'Business'],
    ['Nightlife', 'Nightlife']
  ]



end
