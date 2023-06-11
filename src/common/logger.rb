# frozen_string_literal: true

require 'logger'
require 'colorize'
require './src/config/config_loader'

class Log
  def initialize
    @logger = Logger.new(ConfigLoader.instance.get_attribute('LogFilePath'))
  end

  @instance = new
  private_class_method :new

  class << self
    attr_reader :instance
  end

  def info(msg)
    puts msg
    @logger.info(msg)
  end

  def debug(msg)
    @logger.debug(msg)
  end

  def error(msg)
    puts msg.colorize(background: :red)
    @logger.error(msg)
  end

  def success(msg)
    puts msg.colorize(background: :green)
    @logger.info(msg)
  end
end
