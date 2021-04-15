# Use module instance variables instead of global variables.

# good
module Foo
  class << self
    attr_accessor :bar
  end
end

Foo.bar = 1
