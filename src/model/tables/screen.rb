# frozen_string_literal: true

require './src/model/repository/model'

class Screen < Model
  def create(name)
    @model_store.create({ name: })
  end
end
