# frozen_string_literal: true

require './src/model/repository/repository'

# This is an application level interface for repository
class Model
  def initialize
    @model_store = Repository.new
  end

  def all
    @model_store.all
  end

  def create(attributes)
    @model_store.create(attributes)
  end

  def find(id)
    @model_store.find(id)
  end

  def find_by(field_name, target_value)
    @model_store.find_by(field_name, target_value)
  end

  def filter_by(field_name, target_value)
    @model_store.filter_by(field_name, target_value)
  end

  def update(user)
    @model_store.update(user)
  end

  def delete(id)
    @model_store.delete(id)
  end

  def truncate
    @model_store.truncate
  end
end
