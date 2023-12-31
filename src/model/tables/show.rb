# frozen_string_literal: true

require './src/model/repository/model'

# This is a table for show information
class Show < Model
  def create(show_name, show_date, show_time, screen_id)
    @model_store.create({ show_name:, show_date:, show_time:, screen_id: })
  end
end
