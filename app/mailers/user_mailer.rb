class UserMailer < ApplicationMailer

  def confirm(user)
    @user = user
    mail(to: user.email, subject: "Your registration at #{Rails.application.config.site[:name]}")
  end

  def password(user)
    @user = user
    mail(to: user.email, subject: "#{Rails.application.config.site[:name]} - Password recovery")
  end
end
