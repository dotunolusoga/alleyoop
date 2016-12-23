class Experience < ActiveRecord::Base
  belongs_to :user

  validates :experience_type, presence: true
  validates :experience_title, presence: true
  validates :tagline, presence: true
  validates :summary, presence: true
  validates :about_host, presence: true
  validates :experience_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :capacity, presence: true
  validates :price, presence: true
end
