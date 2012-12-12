class ReservationPdf < Prawn::Document
  def initialize(reservation, view)
    super(top_margin: 70)
    @reservation = reservation
    @view = view
    parking_box
    garage_instructions
    logo
    park_pass
  end
  
  def parking_box
    width = 520
    height = 200
    x = 10
    y = 700
    
    stroke_color "eaeaea"
    line_width 4

    stroke_rectangle [x, y], width, height
    stroke_rectangle [x, y], 185, 50
    text_box "Parking Pass #:", at: [x + 6, y - 7], size: 8
    text_box "#{@reservation.confirmation_number}", at: [x + 60, y - 20], size: 20
    text_box "Questions?", at: [x + 10, y - 150]
    text_box "email: info@sharethelot.com", at: [x + 10, y - 170]
    stroke_rectangle [x + 185, y], width - 185, 50
    text_box "Building:", at: [x + 191, y - 7], size: 8
    text_box "#{@reservation.spot.building.name}", at: [x + 250, y - 18], size: 20
    stroke_rectangle [x + 185, y - 50], width - 185, 50
    text_box "Spot:", at: [x + 191, y - 57], size: 8
    text_box "#{@reservation.spot.name}", at: [x + 220, y - 68], size: 20
    stroke_rectangle [x + 280, y - 50], width - 280, 50
    text_box "Date/Time:", at: [x + 286, y - 57], size: 8
    text_box "#{@reservation.start_date.strftime("%b %e, %Y")} #{@reservation.time_slot_start_hour} - 
              #{@reservation.end_date.strftime("%b %e, %Y")} #{@reservation.time_slot_end_hour} (CST)", 
		          at: [x + 330, y - 64], size: 12
		stroke_rectangle [x + 185, y - 100], width - 185, 50
		text_box "Location:", at: [x + 191, y - 106], size: 8
		text_box "#{@reservation.spot.building.address} 
		          #{@reservation.spot.building.city}, #{@reservation.spot.building.state} #{@reservation.spot.building.zip_code}",
		          at: [x + 250, y - 115], size: 12
  end
  
  def garage_instructions
    width = 360
    height = 400
    x = 10
    y = 470
    
    stroke_color "eaeaea"
    line_width 1
    stroke_rectangle [x, y], width, height
    text_box "Garage Instructions:", at: [x + 10, y - 10]
    text_box "#{@reservation.spot.building.garage_instructions}", at: [x + 10, y - 35], size: 10, width: width - 20
  end
  
  def logo
    x = 420
    y = 30
    text_box "ShareTheLot", at: [x, y]
    text_box "www.sharethelot.com", at: [x, y - 15]
  end
  
  def park_pass
    x = 450
    y = 150
    
    text_box "Parking Pass", at: [x, y], size: 40, rotate: 90, width: 500, height: 100
  end
  
  def price(num)
    @view.number_to_currency(num)
  end
  
end