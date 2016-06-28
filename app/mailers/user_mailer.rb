class UserMailer < ApplicationMailer

	def send_reset_code(user)
    @user = user
    mail(to: user.email, subject: "Reset")
  end
  
end
