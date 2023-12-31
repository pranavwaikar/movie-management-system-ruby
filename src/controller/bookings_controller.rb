# frozen_string_literal: true

require './src/model/database/database'
require './src/controller/seats_controller'
require './src/controller/shows_controller'
require './src/controller/bookings_controller'
require './src/config/config_loader'

# Handels the bookings related activities
class BookingsController
  def create(show_id, seat_id)
    if seat_available?(show_id, seat_id)
      base_price = calculate_base_price(seat_id)
      service_tax = calculate_service_tax(base_price)
      swatch_bharat_cess = calculate_swatch_bharat_cess(base_price)
      krishi_kalyan_cess = calculate_krishi_kalyan_cess(base_price)
      total = base_price + service_tax + krishi_kalyan_cess + swatch_bharat_cess

      return Database.BOOKINGS.create(show_id, seat_id, base_price, service_tax, swatch_bharat_cess,
                                      krishi_kalyan_cess, total)
    end

    -1
  end

  # print booking
  def show(id)
    result = Database.BOOKINGS.find(id)

    if result
      return {
        show: Database.SHOWS.find(result[:show_id]),
        seat: Database.SEATS.find(result[:seat_id]),
        subtotal: result[:base_price],
        service_tax_percentage: ConfigLoader.instance.get_attribute('serviceTax'),
        swachh_bharat_cess_percentage: ConfigLoader.instance.get_attribute('swatchBharatCess'),
        krishikalyan_cess_percentage: ConfigLoader.instance.get_attribute('krishiKalyanCess'),
        service_tax: result[:service_tax],
        swachh_bharat_cess: result[:swachh_bharat_cess],
        krishikalyan_cess: result[:krishikalyan_cess],
        total_price: result[:total_price]
      }
    end

    -1
  end

  def seat_available?(show_id, seat_id)
    seat_map = ShowsController.new.get_available_seats(show_id)
    target_seat = seat_map.find { |seat| seat[:id] == seat_id }

    return true if target_seat

    false
  end

  def calculate_base_price(seat_id)
    SeatsController.new.get_seat_price(seat_id)
  end

  def calculate_service_tax(base_price)
    (base_price / 100) * ConfigLoader.instance.get_attribute('serviceTax') if base_price.is_a? Numeric
  end

  def calculate_krishi_kalyan_cess(base_price)
    (base_price / 100) * ConfigLoader.instance.get_attribute('krishiKalyanCess') if base_price.is_a? Numeric
  end

  def calculate_swatch_bharat_cess(base_price)
    (base_price / 100) * ConfigLoader.instance.get_attribute('swatchBharatCess') if base_price.is_a? Numeric
  end

  def get_revenue_stats
    all_bookings = Database.BOOKINGS.all
    base_revenue = calculate_revenue(all_bookings)
    service_tax_revenue = calculate_service_tax_revenue(all_bookings)
    krishi_kalyan_cess = calculate_krishikalyan_cess_revenue(all_bookings)
    swatch_bharat_cess = calculate_swatch_bharat_cess_revenue(all_bookings)

    {
      base_revenue:,
      service_tax_revenue:,
      krishi_kalyan_cess:,
      swatch_bharat_cess:
    }
  end

  def calculate_revenue(all_bookings)
    prices = all_bookings.map { |booking| booking[:base_price] }
    prices.sum
  end

  def calculate_service_tax_revenue(all_bookings)
    prices = all_bookings.map { |booking| booking[:service_tax] }
    prices.sum
  end

  def calculate_krishikalyan_cess_revenue(all_bookings)
    prices = all_bookings.map { |booking| booking[:krishikalyan_cess] }
    prices.sum
  end

  def calculate_swatch_bharat_cess_revenue(all_bookings)
    prices = all_bookings.map { |booking| booking[:swachh_bharat_cess] }
    prices.sum
  end
end
