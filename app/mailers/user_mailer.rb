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
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "ShareTheLot - Parking Pass", 
    from: "orders@sharethelot.com")
  end
  
  def reservation_email_no_user(reservation)
    @reservation = reservation
    mail(to: "<#{reservation.email}>", subject: "ShareTheLot - Parking Pass", 
    from: "orders@sharethelot.com")
  end
  
  def new_building_admin_email(building)
    @building = building
    mail(to: "info@sharethelot.com", subject: "ShareTheLot - NEW BUILDING")
  end
end
