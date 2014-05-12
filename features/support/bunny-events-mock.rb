Object.send(:remove_const, :Bunny)

class Bunny

  def initialize(string); end

  def create_channel
    Bunny::Channel.new
  end

  def method_missing(m, *args, &block)
    puts "Method #{m} for the class Bunny is stubbed for testing and is not running."
  end
end

class Bunny::Channel

  def queue(name = AMQ::Protocol::EMPTY_STRING, opts = {})
    Bunny::Queue.new
  end

  def nack(delivery_tag, multiple = false, requeue = false)
    $nacked ||= []
    $nacked << delivery_tag
  end

  def reject(delivery_tag, requeue = false)
    nack(delivery_tag, false, requeue)
  end

  def method_missing(m, *args, &block)
    puts "Method #{m} for the class Channel is stubbed for testing and is not running."
  end
end

class Bunny::Queue
  def method_missing(m, *args, &block)
    puts "Method #{m} for the class Queue is stubbed for testing and is not running."
  end
end

class Bunny::DeliveryInfo

  attr_accessor :identifier

  def initialize
    @identifier = Random.new().rand()
  end

  def delivery_tag
    @identifier
  end

  def method_missing(m, *args, &block)
    puts "Method #{m} for the class DeliveryInfo is stubbed for testing and is not running."
  end
end