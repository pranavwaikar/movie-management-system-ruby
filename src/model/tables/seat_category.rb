# frozen_string_literal: true

require './src/model/repository/model'

# This is a table for seat category information
class SeatCategory < Model
  def create(seat_category, price)
    @model_store.create({ seat_category:, price: })
  end
end
