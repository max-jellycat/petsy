class UserMailer < ApplicationMailer

  def confirm(user)
    @user = user
    mail(to: user.email, subject: "Your registration at #{Rails.application.config.site[:name]}")
  end

end
