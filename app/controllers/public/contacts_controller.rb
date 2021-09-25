class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to thank_contacts_path
    else
      render :new
    end
  end

  def thank; end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :message)
  end
end
