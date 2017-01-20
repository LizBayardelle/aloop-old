class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def admin_only
  	unless current_user && current_user.admin
  		redirect_to root_path
  		flash[:notice] = "Sorry, you have to be an administrator to see that page!"
  	end
  end
end
