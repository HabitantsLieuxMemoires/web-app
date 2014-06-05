class UserMailer < ActionMailer::Base

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(to: user.email,
         subject: "Your password has been reset")
  end

  def warn_email(user, article)
    @user     = user
    @article  = article.title
    mail(to: user.email,
         subject: "You have been warned")
  end

  def ban_email(user, article)
    @user     = user
    @article  = article.title
    mail(to: user.email,
         subject: "You have been banned")
  end
end
