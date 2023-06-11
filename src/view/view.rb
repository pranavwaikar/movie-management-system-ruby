require 'colorize'
require './src/common/logger'
require './src/controller/shows_controller'
require './src/model/database/database'

# Handels the overall view
class View
  # print row as per status. If booked - Red and if available - Green
  def print_category_row(seat_map)
    seats = seat_map.map do |seat|
      result = if seat[:status] == 'AVAILABLE'
                 seat[:name].colorize(background: :green)
               else
                 seat[:name].colorize(background: :red)
               end
      result
    end

    Log.instance.info(seats.join(' '))
  end

  # print the seating chart for a specific show
  def show_seating_chart(show_id)
    show = Database.SHOWS.find(show_id)
    screen = Database.SCREENS.find(show[:screen_id])
    seat_map = ShowsController.new.get_seat_map_with_status(show_id)

    # separate out by the seat category
    platimum = seat_map.select { |seat| seat[:seat_category_id] == 1 }
    gold = seat_map.select { |seat| seat[:seat_category_id] == 2 }
    silver = seat_map.select { |seat| seat[:seat_category_id] == 3 }

    # print the seating rows
    Log.instance.info("Available seats for Show #{show_id}: at #{screen[:name]} :")
    print_category_row(platimum)
    print_category_row(gold)
    print_category_row(silver)
  end

  # For every show print the seating chart
  def show_all_seating_charts
    shows = Database.SHOWS.all
    shows.each { |show| show_seating_chart(show[:id]) }
  end

  # Ask for seat selection
  def take_seat_input
    Log.instance.info 'Enter seat numbers to book (e.g. A1,A2): '
    selected_seats = gets.chomp.upcase.strip
    processed_seat = []
    if selected_seats.include?(',')
      selected_seats.split(',').map(&:chomp).map(&:strip)
    else
      [selected_seats]
    end
  end

  def print_booking_info(booking_id)
    booking_info = BookingsController.new.show(booking_id)
    Log.instance.info('-----')
    Log.instance.success("Successfully Booked - Show #{booking_info[:show][:id]} - Seat #{booking_info[:seat][:name]}")
    Log.instance.info("Subtotal: Rs. #{booking_info[:subtotal]}")
    Log.instance.info("Service Tax @#{booking_info[:service_tax_percentage]}% : Rs. #{booking_info[:service_tax]}")
    Log.instance.info("Swachh Bharat Cess @#{booking_info[:swachh_bharat_cess_percentage]}% : Rs.  #{booking_info[:swachh_bharat_cess]}")
    Log.instance.info("Krishi Kalyan Cess @#{booking_info[:krishikalyan_cess_percentage]}% : Rs. #{booking_info[:krishikalyan_cess]}")
    Log.instance.info("Total: Rs. #{booking_info[:total_price]}")
    Log.instance.info('-----')
  end

  def print_revenue_stats
    revenue_info = BookingsController.new.get_revenue_stats

    Log.instance.info('-----')
    Log.instance.info('Total Sales:'.colorize(background: :blue))
    Log.instance.info("Revenue: Rs. #{revenue_info[:base_revenue]}")
    Log.instance.info("Service Tax: Rs. #{revenue_info[:service_tax_revenue]}")
    Log.instance.info("Swachh Bharat Cess: Rs. #{revenue_info[:swatch_bharat_cess]}")
    Log.instance.info("Krishi Kalyan Cess: Rs. #{revenue_info[:krishi_kalyan_cess]}")
    Log.instance.info('-----')
  end

  def book_seat(seat_name, show_id)
    seat = SeatsController.new.get_seat_by_name(seat_name, show_id)
    result = BookingsController.new.create(show_id, seat[:id])
    if result == -1
      Log.instance.error('Failed to book a new ticket! ')
    else
      print_booking_info(result[:id])
    end
  end

  def start
    # Start the booking process
    Log.instance.info 'Welcome to the Movie Theater!'

    begin
      loop do
        show_all_seating_charts
        Log.instance.info 'Enter the show number (1, 2, 3): '
        show_id = gets.chomp.to_i

        raise 'The show number must be integer !' unless show_id.is_a? Numeric

        Log.instance.info('-----')
        show_seating_chart(show_id)
        seat_inputs = take_seat_input
        seat_inputs.map { |seat_name| book_seat(seat_name, show_id) }

        Log.instance.info('Would you like to continue (Y/N):')
        continue_flag = gets.chomp.upcase
        break if continue_flag == 'N'
      end
      print_revenue_stats
    rescue StandardError
      Log.instance.error('Something went wrong while execution. Mostly invalid inputs is the cause. Please try again!')
    end
  end
end
