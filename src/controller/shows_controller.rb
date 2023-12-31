# frozen_string_literal: true

require './src/model/database/database'

# Handels the shows related activities
class ShowsController
  def get_screen_id(show_id)
    target_show = Database.SHOWS.find(show_id)
    return target_show[:screen_id] if target_show

    -1
  end

  # lists all the seats in given screen
  def get_all_seats(screen_id)
    seat_list = Database.SEATS.filter_by('screen_id', screen_id)
    return seat_list if seat_list.length.positive?

    -1
  end

  # lists all available seats in given show
  def get_available_seats(show_id)
    # get screen id
    screen_id = get_screen_id(show_id)
    # get seat map
    seat_map = get_all_seats(screen_id)

    # get booked seat
    booking_list = get_all_bookings(show_id)
    booked_seat_ids = booking_list.map { |booking| booking[:seat_id] }

    # reduce the booked seats
    seat_map.reject { |seat| booked_seat_ids.include?(seat[:id]) } unless seat_map == -1
  end

  def get_all_bookings(show_id)
    booking_list = Database.BOOKINGS.filter_by('show_id', show_id)
    return booking_list if booking_list
  end

  # lists all seats in given show with seat status as booked or available
  def get_seat_map_with_status(show_id)
    # get screen id
    screen_id = get_screen_id(show_id)
    # get seat map
    seat_mappings = get_all_seats(screen_id)
    return -1 if seat_mappings == -1

    seat_map = seat_mappings.map(&:clone)

    # get booked seat
    booking_list = get_all_bookings(show_id)
    booked_seat_ids = booking_list.map { |booking| booking[:seat_id] }

    # mark the booked seats
    seat_map.map do |seat|
      seat[:status] = if booked_seat_ids.include?(seat[:id])
                        'BOOKED'
                      else
                        'AVAILABLE'
                      end
      seat
    end
  end
end
