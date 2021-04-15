StyleGuide: 'https://github.com/bbatsov/ruby-style-guide#def-self-class-methods'

# Use def self.method to define class methods.
# This makes the code easier to refactor since the class name is not repeated.

class TestClass
  # bad
  def TestClass.some_method
    # body omitted
  end

  # Also possible and convenient when you
  # have to define many class methods.
  class << self
    def first_method
      # body omitted
    end

    def second_method_etc
      # body omitted
    end
  end
end
