# 'https://github.com/bbatsov/ruby-style-guide#hash-key'

# Use Hash#key? instead of Hash#has_key? and Hash#value?
#   instead of Hash#has_value?. As noted here by Matz,
#   the longer forms are considered deprecated.

# bad
hash.has_key?(:test)
hash.has_value?(value)
