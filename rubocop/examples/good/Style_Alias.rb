# 'https://github.com/bbatsov/ruby-style-guide#alias-method'

# Always use alias_method when aliasing methods of modules, classes, or singleton classes at runtime
# as the lexical scope of alias leads to unpredictability in these cases.

# good

module Mononymous
  def self.included(other)
    other.class_eval { alias_method :full_name, :given_name }
  end
end

class Sting < Westerner
  include Mononymous
end
