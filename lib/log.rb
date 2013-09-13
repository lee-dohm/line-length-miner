#
# Copyright (c) 2013 by Lifted Studios. All Rights Reserved.
#

require 'logger'

# Handles logging for the application.
#
# @see http://rubydoc.org/stdlib/logger/Logger Ruby standard library Logger class.
class Log
  # Log a `DEBUG` message.
  #
  # @param [String] message Message to be logged.
  # @yieldreturn [String] Message to be logged.
  def self.debug(message = nil, &block)
    Log.ensure_logger

    @logger.debug(message, &block)
  end

  # Ensures that a `Logger` object has been created and configured.
  def self.ensure_logger
    if @logger.nil?
      @logger = Logger.new($stdout)
      @logger.level = Logger::WARN
      @logger.progname = $0
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      @logger.formatter = proc { |_, timestamp, _, message| "#{timestamp}: #{message}\n" }
    end
  end

  # Log a `DEBUG` message.
  #
  # @param [String] message Message to be logged.
  # @yieldreturn [String] Message to be logged.
  def self.error(message = nil, &block)
    Log.ensure_logger

    @logger.error(message, &block)
  end

  # Log a `FATAL` message.
  #
  # @param [String] message Message to be logged.
  # @yieldreturn [String] Message to be logged.
  def self.fatal(message = nil, &block)
    Log.ensure_logger

    @logger.fatal(message, &block)
  end

  # Log an `INFO` message.
  #
  # @param [String] message Message to be logged.
  # @yieldreturn [String] Message to be logged.
  def self.info(message = nil, &block)
    Log.ensure_logger

    @logger.info(message, &block)
  end

  # Gets the current logging level.
  #
  # @return
  #     [Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, Logger::WARN]
  #     Current minimum level of messages that will be logged.
  def self.level
    Log.ensure_logger

    @logger.level
  end

  # Sets the current logging level.
  #
  # @param
  #     [Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, Logger::WARN]
  #     level Minimum level of messages that will be logged.
  # @return [nil]
  def self.level=(level)
    Log.ensure_logger

    @logger.level = level

    nil
  end

  # Log an `UNKNOWN` message.
  #
  # @param [String] message Message to be logged.
  # @yieldreturn [String] Message to be logged.
  def self.unknown(message = nil, &block)
    Log.ensure_logger

    @logger.unknown(message, &block)
  end

  # Log a `WARN` message.
  #
  # @param [String] message Message to be logged.
  # @yieldreturn [String] Message to be logged.
  def self.warn(message = nil, &block)
    Log.ensure_logger

    @logger.warn(message, &block)
  end

  class << self
    alias_method :d, :debug
    alias_method :e, :error
    alias_method :f, :fatal
    alias_method :i, :info
    alias_method :u, :unknown
    alias_method :w, :warn
  end
end
