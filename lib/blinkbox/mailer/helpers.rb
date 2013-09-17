# This class allows you to know if a string has been used.
#
#     a = ActionString.new("Hello")
#     p a
#     # => "Hello"
#     p a.used?
#     # => false
#     p "#{a} world"
#     # => "Hello world"
#     p a.used?
#     # => true
#
class ActionString
  def initialize(string)
    @string = string
  end

  def used?
    @used || false
  end

  def to_s
    @used = true
    @string
  end

  def inspect
    @string
  end

  def respond_to?(m)
    @string.respond_to?(m)
  end

  def method_missing(m, *args)
    if respond_to?(m)
      @used = true
      @string.send(m)
    else
      super
    end
  end
end