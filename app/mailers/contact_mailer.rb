class ContactMailer < ActionMailer::Base

  def new_message(message)
    @message = message
    mail(:subject => "[Contact] #{message.subject}")
  end

end
