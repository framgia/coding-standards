# 'https://github.com/bbatsov/ruby-style-guide#indent-public-private-protected'

# Indent the public, protected, and private methods as much as the method definitions they apply to.
# Leave one blank line above the visibility modifier and one blank line below in order to emphasize that it applies to all methods below it

# bad
class SomeClass
  def public_method
    # ...
  end

  private
  def private_method
    # ...
  end

  def another_private_method
    # ...
  end
end
