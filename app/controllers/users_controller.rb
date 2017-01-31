class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@unapproved_photos = Photo.where(approved: false)
  end
end
