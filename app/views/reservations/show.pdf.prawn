pdf.text "Confirmation ##{@reservation.confirmation_number}", :size => 30, :style => :bold

pdf.move_down(30)

items = [
  [@reservation.spot.building.name],
  [@reservation.start_date.strftime("%b %e, %Y") @reservation.time_slot_start_hour - 
	 @reservation.end_date.strftime("%b %e, %Y") @reservation.time_slot_end_hour]
  ]

pdf.table items, :border_style => :grid,
  :row_colors => ["FFFFFF","DDDDDD"],
  :headers => ["Product",
  :align => { 0 => :left, 1 => :right, 2 => :right, 3 => :right }

pdf.move_down(10)

# pdf.text "Total Price: #{number_to_currency(@order.cart.total_price)}", :size => 16, :style => :bold
