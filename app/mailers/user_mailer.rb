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

  def send_ac_delete_code(user)
  	@user = user
  	mail(to: user.email, subject: "Your A/C delete code")
  end

  def send_ac_deactivate_mail(user)
    @user = user
    mail(to: user.email, subject: "Your A/C is successfully deactivated.!")
  end

  def send_ac_reactivate_mail(user)
    @user = user
    mail(to: user.email, subject: "Your A/C is successfully reactivated.!")
  end

  def send_group_code(group,email)
    @group = group
    mail(to: email, subject: "Invitation")
  end

end
