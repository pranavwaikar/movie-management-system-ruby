# frozen_string_literal: true

require './src/model/repository/Model'

class Booking < Model
  def create(show_id, seat_id, base_price, service_tax, swachh_bharat_cess, krishikalyan_cess, total_price)
    @model_store.create({ show_id:, seat_id:, base_price:, service_tax:,
                          swachh_bharat_cess:, krishikalyan_cess:, total_price: })
  end
end
