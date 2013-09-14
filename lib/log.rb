#
# Copyright (c) 2013 by Lifted Studios. All Rights Reserved.
#

require 'logger'

# A simplified logging interface.
#
# Most applications just need to write to the one canonical log sink. This makes that simple.
# Inspired by the Android logging framework, this class allows one to simply log at various levels
# without having to configure even a single `Logger` object.
#
# @example Logging a simple message
#     Log.w('Simple message')
#
# @example Logging a formatted message
#     Log.w("Message with some #{data} in it")
#
# @example Using a block to not create the message unless it will actually be written
#     Log.w { "Some complicated message: #{long_running_function}" }
#
# @see http://rubydoc.org/stdlib/logger/Logger Ruby standard library Logger class.
class Log
  class << self
    attr_accessor :level
  end

  # Log a `DEBUG` message.
  #
  # @param [String] message Message to be logged.
  # @return [Boolean] `true` if successful; `false` otherwise.
  # @yieldreturn [String] Message to be logged.
  def self.debug(message = nil, &block)
    ensure_logger

    @logger.debug(message, &block)
  end

  # Ensures that a `Logger` object has been created and configured.
  #
  # @return [nil]
  def self.ensure_logger
    if @logger.nil?
      @logger = Logger.new($stdout)
      @logger.level = Logger::WARN
      @logger.progname = $0
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      @logger.formatter = proc { |_, timestamp, _, message| "#{timestamp}: #{message}\n" }
    end

    nil
  end

  # Log a `DEBUG` message.
  #
  # @param [String] message Message to be logged.
  # @return [Boolean] `true` if successful; `false` otherwise.
  # @yieldreturn [String] Message to be logged.
  def self.error(message = nil, &block)
    ensure_logger

    @logger.error(message, &block)
  end

  # Logs an exception.
  #
  # Logs the exception as a series of `FATAL` messages.
  #
  # @param [Exception] e Exception to be logged.
  # @return [nil]
  def self.exception(e)
    Log.f("#{e.class}: #{e}")
    e.backtrace.each { |b| Log.f("    #{b}") }

    nil
  end

  # Log a `FATAL` message.
  #
  # @param [String] message Message to be logged.
  # @return [Boolean] `true` if successful; `false` otherwise.
  # @yieldreturn [String] Message to be logged.
  def self.fatal(message = nil, &block)
    ensure_logger

    @logger.fatal(message, &block)
  end

  # Log an `INFO` message.
  #
  # @param [String] message Message to be logged.
  # @return [Boolean] `true` if successful; `false` otherwise.
  # @yieldreturn [String] Message to be logged.
  def self.info(message = nil, &block)
    ensure_logger

    @logger.info(message, &block)
  end

  # @return
  #     [Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, Logger::WARN]
  #     Logging severity threshold.
  def self.level
    ensure_logger

    @logger.level
  end

  # @param
  #     [Logger::DEBUG, Logger::ERROR, Logger::FATAL, Logger::INFO, Logger::UNKNOWN, Logger::WARN]
  #     level Logging severity threshold.
  def self.level=(level)
    ensure_logger

    @logger.level = level
  end

  # Log an `UNKNOWN` message.
  #
  # @param [String] message Message to be logged.
  # @return [Boolean] `true` if successful; `false` otherwise.
  # @yieldreturn [String] Message to be logged.
  def self.unknown(message = nil, &block)
    ensure_logger

    @logger.unknown(message, &block)
  end

  # Log a `WARN` message.
  #
  # @param [String] message Message to be logged.
  # @return [Boolean] `true` if successful; `false` otherwise.
  # @yieldreturn [String] Message to be logged.
  def self.warn(message = nil, &block)
    ensure_logger

    @logger.warn(message, &block)
  end

  class << self
    private :ensure_logger

    alias_method :d, :debug
    alias_method :e, :error
    alias_method :f, :fatal
    alias_method :i, :info
    alias_method :u, :unknown
    alias_method :w, :warn
    alias_method :wtf, :exception
  end
end
