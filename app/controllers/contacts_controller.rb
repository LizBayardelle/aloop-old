class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, except: [:show, :new, :create]

  # GET /contacts
  def index
    @contacts = Contact.where(archived: false)
    @archived = Contact.where(archived: true)
  end

  # GET /contacts/1
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    if current_user 
      @contact.user = current_user
    end

    if @contact.save
      redirect_to root_path, notice: "Your message has been sent!  We'll get back to you soon."
    else
      render :new
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: 'The message has been edited successfully.'
    else
      render :edit
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: 'That message has been deleted successfully!'
  end

  
  def archive
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(archived: true)
      flash[:notice] = "That message has been archived!"
      redirect_to :back
    else
      flash[:alert] = "That message could not be archived right now."
    end
  end

  def unarchive
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(archived: false)
      flash[:notice] = "That message has been moved back to the current messages section."
      redirect_to :back
    else
      flash[:alert] = "That message could not be unarchived right now."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone, :preferred_contact_method, :subject, :message, :user_id, :read, :archived)
    end
end
