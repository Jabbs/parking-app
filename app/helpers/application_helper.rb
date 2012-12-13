module ApplicationHelper
  
  def price_of_reservation(rent_hour_count)
    if rent_hour_count < 4
      price = rent_hour_count * 3
    elsif rent_hour_count < 8
      price = 10
    elsif rent_hour_count < 25
      price = 20
    else
      price = ((rent_hour_count.to_f / 24.to_f) * 20).round
    end
    price
  end
  
  def total_price(reservations)
    total = 0
    reservations.each do |res|
      total = total + res.amount
    end
    total
  end
  
end
