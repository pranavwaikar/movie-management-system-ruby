# frozen_string_literal: true

require './src/model/repository/model'

# This is a table for booking information
class Booking < Model
  def create(show_id, seat_id, base_price, service_tax, swachh_bharat_cess, krishikalyan_cess, total_price)
    @model_store.create({ show_id:, seat_id:, base_price:, service_tax:,
                          swachh_bharat_cess:, krishikalyan_cess:, total_price: })
  end
end
