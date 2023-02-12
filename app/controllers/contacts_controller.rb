## This is for the contact form on the homepage
class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.deliver
      redirect_to root_path, notice: "Thank you for your message!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :nickname)
  end
end
