# frozen_string_literal: true

require './src/model/repository/Model'

class Screen < Model
  def create(name)
    @model_store.create({ name: })
  end
end
