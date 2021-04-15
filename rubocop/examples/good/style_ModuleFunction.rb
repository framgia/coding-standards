# Favor the use of module_function over extend self when you want
#   to turn a module's instance methods into class methods.

# good
module Utilities
  module_function

  def parse_something(string)
    # do stuff here
  end

  def other_utility_method(number, string)
    # do some more stuff
  end
end
