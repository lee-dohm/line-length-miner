#
# Copyright (c) 2013 by Lifted Studios. All Rights Reserved.
#

require 'logger'

# Handles logging for the application.
class Log
  def self.debug(message, &block)
    Log.ensure_logger

    @logger.debug(message, block)
  end

  def self.ensure_logger
    if @logger.nil?
      @logger = Logger.new($stdout)
      @logger.level = Logger::WARN
      @logger.progname = $0
    end
  end

  def self.error(message, &block)
    Log.ensure_logger

    @logger.error(message, block)
  end

  def self.fatal(message, &block)
    Log.ensure_logger

    @logger.fatal(message, block)
  end

  def self.info(message, &block)
    Log.ensure_logger

    @logger.info(message, block)
  end

  def self.level
    Log.ensure_logger

    @logger.level
  end

  def self.level=(level)
    Log.ensure_logger

    @logger.level = level
  end

  def self.unknown(message, &block)
    Log.ensure_logger

    @logger.unknown(message, block)
  end

  def self.warn(message, &block)
    Log.ensure_logger

    @logger.warn(message, block)
  end
end
