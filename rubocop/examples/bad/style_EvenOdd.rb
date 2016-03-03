# This cop checks for places where Fixnum#even?
#   or Fixnum#odd? should have been used.

# bad
if x % 2 == 0
