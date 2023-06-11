# frozen_string_literal: true

require 'json'

# This is an interface to interact with the configuration layer
class ConfigLoader
  def initialize
    file = File.read('./src/config/config.json')
    @data_hash = JSON.parse(file)
  end

  @instance = new
  private_class_method :new

  class << self
    attr_reader :instance
  end

  def get_attribute(attr)
    @data_hash[attr.to_s]
  end
end
