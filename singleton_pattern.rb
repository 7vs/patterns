class SimpleLogger
  attr_accessor :level

  ERROR = 1
  WARNING = 2
  INFO = 3  

  def initialize
    @log = File.open("log.txt", "w")
    @level = WARNING
  end
  
  def error(msg)
    @log.puts(msg)
    @log.flush
  end
  
  def warning(msg)
    @log.puts(msg) if @level >= WARNING
    @log.flush
  end

  def info(msg)
    @log.puts(msg) if @level >= INFO
    @log.flush
  end

  #class methods
  def self.instance
    @@instance ||= SimpleLogger.new 
  end

  private_class_method :new #evil twin: public_class_method
end

# logger = SimpleLogger.new
# logger.level = SimpleLogger::INFO
# logger.info('Doing the first thing')
# Do the first thing...
# logger.info('Now doing the second thing')
# Do the second thing...

logger1 = SimpleLogger.instance # Returns the logger
logger2 = SimpleLogger.instance # Returns exactly the same logger

SimpleLogger.instance.info('Computer wins chess game.')
SimpleLogger.instance.warning('AE-35 hardware failure predicted.')
SimpleLogger.instance.error('HAL-9000 malfunction, take emergency action!')

# require 'singleton'

# class SimpleLogger
#   include Singleton
#   # Lots of code deleted...
# end

#classes as singletons
# class ClassBasedLogger
# #module ModuleBasedLogger
#   ERROR = 1
#   WARNING = 2
#   INFO = 3

#   @@log = File.open('log.txt', 'w')
#   @@level = WARNING

#   def self.error(msg)
#     @@log.puts(msg)
#     @@log.flush
#   end
  
#   def self.warning(msg)
#     @@log.puts(msg) if @@level >= WARNING
#     @@log.flush
#   end
  
#   def self.info(msg)
#     @@log.puts(msg) if @@level >= INFO
#     @@log.flush
#   end
  
#   def self.level=(new_level)
#     @@level = new_level
#   end

#   def self.level
#     @@level
#   end
# end

# ClassBasedLogger.level = ClassBasedLogger::INFO
# ClassBasedLogger.info('Computer wins chess game.')
# ClassBasedLogger.warning('AE-35 hardware failure predicted.')
# ClassBasedLogger.error('HAL-9000 malfunction, take emergency action!')

# #ModuleBasedLogger.info('Computer wins chess game.')


a_second_logger = ClassBasedLogger.clone
a_second_logger.error('using a second logger')


# require 'singleton'

# class SimpleLogger
#   # All of the logging functionality in this class...
# end
# class SingletonLogger < SimpleLogger
#   include Singleton
# end