# 'https://github.com/bbatsov/ruby-style-guide#array-join'

# Favor the use of Array#join over the fairly cryptic
#   Array#* with a string argument.

# bad
%w(one two three) * ', '
# => 'one, two, three'
