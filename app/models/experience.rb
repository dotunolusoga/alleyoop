class Experience < ActiveRecord::Base
  belongs_to :user

  has_many :reservations
  has_many :reviews

  has_many :image_uploads
  accepts_nested_attributes_for :image_uploads

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  cattr_accessor :form_steps do
    %w(details photos location time amenities notes finishing_touches)
  end

  attr_accessor :form_step

  validates :experience_type, :experience_title, :tagline,
            :summary, :about_host, presence: true, if: -> { required_for_step?(:details) }

  # validates :images, presence: true, if: -> { required_for_step?(:photos) }

  validates :experience_date, :start_time, :end_time,
            presence: true, if: -> { required_for_step?(:time) }

  validates :location_name, :street, :city, :state,
            :zipcode, presence: true, if: -> { required_for_step?(:location) }

  validates :capacity, :price, presence: true, if: -> { required_for_step?(:finishing_touches) }


  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

  def address
    [street, city, state].compact.join(', USA')
  end

  def address_changed?
    street_changed? || city_changed? || state_changed? || zipcode_changed?
  end

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
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
