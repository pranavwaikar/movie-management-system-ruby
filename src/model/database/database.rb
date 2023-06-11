# frozen_string_literal: true

require './src/model/tables/screen'
require './src/model/tables/seat'
require './src/model/tables/seatCategory'
require './src/model/tables/show'
require './src/model/tables/booking'
require './src/config/config_loader'
require './src/controller/bookings_controller'

class Database
  @@seat_category = SeatCategory.new
  @@screens = Screen.new
  @@seats = Seat.new
  @@shows = Show.new
  @@bookings = Booking.new

  def self.SCREENS
    @@screens
  end

  def self.SEAT_CATEGORIES
    @@seat_category
  end

  def self.SEATS
    @@seats
  end

  def self.SHOWS
    @@shows
  end

  def self.BOOKINGS
    @@bookings
  end

  def self.seed
    # create 3 seat categories
    @@seat_category.create('Platinum', ConfigLoader.instance.get_attribute('PlatinumTicketPrice'))
    @@seat_category.create('Gold', ConfigLoader.instance.get_attribute('GoldTicketPrice'))
    @@seat_category.create('Silver', ConfigLoader.instance.get_attribute('SilverTicketPrice'))

    # create 3 screens
    @@screens.create('AUDI 1')
    @@screens.create('AUDI 2')
    @@screens.create('AUDI 3')

    # create seats - name, seat_category_id, screen_id
    @@seats.create('A1', 1, 1) # platinum - AUDI 1
    @@seats.create('A2', 1, 1)
    @@seats.create('A3', 1, 1)

    @@seats.create('B1', 2, 1) # gold - AUDI 1
    @@seats.create('B2', 2, 1)
    @@seats.create('B3', 2, 1)

    @@seats.create('C1', 3, 1) # silver - AUDI 1
    @@seats.create('C2', 3, 1)
    @@seats.create('C3', 3, 1)

    @@seats.create('A1', 1, 2) # platinum - AUDI 2
    @@seats.create('A2', 1, 2)
    @@seats.create('A3', 1, 2)

    @@seats.create('B1', 2, 2) # gold - AUDI 2
    @@seats.create('B2', 2, 2)
    @@seats.create('B3', 2, 2)

    @@seats.create('C1', 3, 2) # silver - AUDI 2
    @@seats.create('C2', 3, 2)
    @@seats.create('C3', 3, 2)

    @@seats.create('A1', 1, 3) # platinum - AUDI 3
    @@seats.create('A2', 1, 3)
    @@seats.create('A3', 1, 3)

    @@seats.create('B1', 2, 3) # gold - AUDI 3
    @@seats.create('B2', 2, 3)
    @@seats.create('B3', 2, 3)

    @@seats.create('C1', 3, 3) # silver - AUDI 3
    @@seats.create('C2', 3, 3)
    @@seats.create('C3', 3, 3)

    # create shows - show_name, show_date, show_time, screen_id
    @@shows.create('show 1', '10 Feb 2020', '12:00 PM', 1) # AUDI 1
    # @@shows.create("show 2", "10 Feb 2020", "03:00 PM", 1)  # AUDI 1
    # @@shows.create("show 3", "10 Feb 2020", "06:00 PM", 1)  # AUDI 1

    # @@shows.create("show 1", "10 Feb 2020", "12:00 PM", 2)  # AUDI 2
    @@shows.create('show 2', '10 Feb 2020', '03:00 PM', 2) # AUDI 2
    # @@shows.create("show 3", "10 Feb 2020", "06:00 PM", 2)  # AUDI 2

    # @@shows.create("show 1", "10 Feb 2020", "12:00 PM", 3)  # AUDI 3
    # @@shows.create("show 2", "10 Feb 2020", "03:00 PM", 3)  # AUDI 3
    @@shows.create('show 3', '10 Feb 2020', '06:00 PM', 3) # AUDI 3

    # create a booking - show_id, seat_id, base_price, service_tax, swachh_bharat_cess, krishikalyan_cess, total_price
    BookingsController.new.create(1, 1)
  end
end
