class PhotosController < ApplicationController
  before_action :set_photos, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo = @experience.photos.build

    if @photo.save
      redirect_to @photo, notice: "Image added"
    else
      render 'new'
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo.experience, notice: "Your image change was saved."
    else
      render 'edit'
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: "Images deleted"
  end


  private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:experience_id, :image)
    end

end
