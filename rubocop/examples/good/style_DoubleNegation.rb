# This cop checks for uses of double negation (!!)
#   to convert something to a boolean value.
#   As this is both cryptic and usually redundant it should be avoided.

# good
!something.nil?
