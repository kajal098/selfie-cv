class UserMailer < ApplicationMailer

  def send_reset_code(user)
    @user = user
    mail(to: user.email, subject: "Reset")
  end
  
  def welcome(user,password)
  	@user = user
  	@password = password
    mail(to: user.email, subject: "Welcome to Selfie CV")
  end

end
