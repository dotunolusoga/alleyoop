class Review < ActiveRecord::Base
  belongs_to :experience
  belongs_to :user
end
