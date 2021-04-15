# Use spaces around operators, after commas, colons and semicolons,
#   around { and before }. Whitespace might be (mostly) irrelevant to the
#   Ruby interpreter, but its proper use is the key to
#   writing easily readable code.

sum = 1 + 2
a, b = 1, 2
[1, 2, 3].each { |e| puts e }
class FooError < StandardError; end
The only exception, regarding operators, is the exponent operator:

# bad
e = M * c ** 2

# { and } deserve a bit of clarification, since they are used for block
#   and hash literals, as well as string interpolation.
#   For hash literals two styles are considered acceptable.

# The first variant is slightly more readable (and arguably more
#   popular in the Ruby community in general). The second variant has
#   the advantage of adding visual difference between block and hash literals.
#   Whichever one you pick - apply it consistently.
