class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  def index
    @photos = Photo.all
    @kit_1_photos = Photo.where(kit: "kit_1")
    @kit_2_photos = Photo.where(kit: "kit_2")
    @kit_3_photos = Photo.where(kit: "kit_3")
  end

  # GET /photos/1
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    if @photo.save
      redirect_to photos_path, notice: 'Your photo has been submitted. Check back soon to see it live!'
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  def update
    @photo.update_attributes(approved: false)
    if @photo.update(photo_params)
      redirect_to photos_path, notice: 'Your entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:image, :user_id, :approved, :comments, :kit)
    end
end
