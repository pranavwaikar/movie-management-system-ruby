# frozen_string_literal: true

require './src/model/database/database'

# Handels the seats related activities
class SeatsController
  def get_seat_by_name(seat_name, show_id)
    show = Database.SHOWS.find(show_id)
    seats = Database.SEATS.filter_by('screen_id', show[:screen_id])
    seats.find { |ele| ele[:name] == seat_name }
  end

  # get seat price by seat id
  def get_seat_price(seat_id)
    target_seat = Database.SEATS.find(seat_id)
    if target_seat
      target_seat_category = Database.SEAT_CATEGORIES.find(target_seat[:seat_category_id])
      return target_seat_category[:price] if target_seat_category
    end

    -1
  end
end
