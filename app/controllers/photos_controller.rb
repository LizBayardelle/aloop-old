class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  def index
    @photos = Photo.where(approved: true)
    @kit_1_photos = Photo.where(kit: "kit_1", approved: true)
    @kit_2_photos = Photo.where(kit: "kit_2", approved: true)
    @kit_3_photos = Photo.where(kit: "kit_3", approved: true)
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

  def approve
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(approved: true)
      GalleryMailer.submission_approved(@photo.user, @photo).deliver_now
      flash[:notice] = "The photo has been sent to the gallery!"
      redirect_to :back
    else
      flash[:alert] = "That photo could not be approved right now."
    end
  end

  def unapprove
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(approved: false)
      flash[:notice] = "The photo has been removed from the gallery!"
      redirect_to :back
    else
      flash[:alert] = "That photo could not be unapproved right now."
    end
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
