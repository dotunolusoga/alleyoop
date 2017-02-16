class ImageUploadsController < ApplicationController
  before_action :set_image_upload, only: [:show, :edit, :update, :destroy]

  # GET /image_uploads
  # GET /image_uploads.json
  def index
    @image_uploads = ImageUpload.all
  end

  # GET /image_uploads/1
  # GET /image_uploads/1.json
  def show
  end

  # GET /image_uploads/new
  def new
    @image_upload = ImageUpload.new
  end

  # GET /image_uploads/1/edit
  def edit
  end

  # POST /image_uploads
  # POST /image_uploads.json
  def create
    @image_upload = ImageUpload.new(image_upload_params)

    respond_to do |format|
      if @image_upload.save
        format.html { redirect_to @image_upload, notice: 'Image upload was successfully created.' }
        format.json { render :show, status: :created, location: @image_upload }
      else
        format.html { render :new }
        format.json { render json: @image_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_uploads/1
  # PATCH/PUT /image_uploads/1.json
  def update
    respond_to do |format|
      if @image_upload.update(image_upload_params)
        format.html { redirect_to @image_upload, notice: 'Image upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_upload }
      else
        format.html { render :edit }
        format.json { render json: @image_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_uploads/1
  # DELETE /image_uploads/1.json
  def destroy
    experience = @image_upload.experience
    @image_upload.destroy

    @image_uploads = ImageUpload.where(experience_id: experience.id)
    respond_to :js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_upload
      @image_upload = ImageUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_upload_params
      params.require(:image_upload).permit(:experience_id, :image)
    end
end
