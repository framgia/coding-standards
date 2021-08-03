# Favor the use of module_function over extend self when you want
#   to turn a module's instance methods into class methods.

# bad
module Utilities
  extend self

  def parse_something(string)
    # do stuff here
  end

  def other_utility_method(number, string)
    # do some more stuff
  end
end
