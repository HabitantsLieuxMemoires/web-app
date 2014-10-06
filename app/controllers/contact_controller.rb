class ContactController < ApplicationController
  skip_before_action :require_login,  only: [:new, :create]

  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(params[:contact_message])

    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to(root_path)
    else
      render :new
    end
  end

end
