# frozen_string_literal: true

require './src/model/repository/model'

class Seat < Model
  def create(name, seat_category_id, screen_id)
    @model_store.create({ name:, seat_category_id:, screen_id: })
  end
end
