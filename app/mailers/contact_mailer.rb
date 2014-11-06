class ContactMailer < ActionMailer::Base

  default to: 'contact@habitantslieuxmemoires.fr'

  def new_message(message)
    @message = message
    mail(:subject => "[Contact] #{message.subject}")
  end

end
