# frozen_string_literal: true

require './src/model/repository/model'

# This is a table for Screen information
class Screen < Model
  def create(name)
    @model_store.create({ name: })
  end
end
