class ImageUpload < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    belongs_to :experience
end
