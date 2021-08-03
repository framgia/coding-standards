# Do not use for, unless you know exactly why.
#   Most of the time iterators should be used instead.
#   for is implemented in terms of each
#   (so you're adding a level of indirection),
#   but with a twist - for doesn't introduce a new scope (unlike each)
#   and variables defined in its block will be visible outside it.

arr = [1, 2, 3]

# good
arr.each { |elem| puts elem }

# elem is not accessible outside each's block
elem # => NameError: undefined local variable or method `elem'
