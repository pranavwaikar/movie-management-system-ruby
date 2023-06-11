# frozen_string_literal: true

require './src/model/repository/in_memory_storage'

class Repository
  def initialize(storage = InMemoryStorage.new)
    @storage = storage
  end

  def find(id)
    @storage.find(id)
  end

  def find_by(field_name, target_value)
    @storage.find_by(field_name, target_value)
  end

  def filter_by(field_name, target_value)
    @storage.filter_by(field_name, target_value)
  end

  def all
    @storage.all
  end

  def create(user)
    @storage.create(user)
  end

  def update(user)
    @storage.update(user)
  end

  def delete(id)
    @storage.delete(id)
  end
end
