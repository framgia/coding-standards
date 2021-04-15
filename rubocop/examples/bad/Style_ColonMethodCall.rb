# 'https://github.com/bbatsov/ruby-style-guide#double-colons'

# Use :: only to reference constants(this includes classes and modules) and
#   constructors (like Array() or Nokogiri::HTML()).
#   Do not use :: for regular method invocation.

# bad
SomeClass::some_method
some_object::some_method
