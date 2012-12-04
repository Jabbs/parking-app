class UserMailer < ActionMailer::Base
  default from: "info@sharethelot.com"
  
  def password_reset(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "ShareTheLot - Password Reset")
  end
  
  def verification_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Verify your ShareTheLot Account")
  end
  
  def reservation_email(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "ShareTheLot - Parking Receipt", 
    from: "orders@sharethelot.com")
  end
end