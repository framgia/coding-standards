# TODO: This cop enforces the use of a single string formatting utility.
#   Valid options include Kernel#format, Kernel#sprintf and String#%.

# TODO: The detection of String#% cannot be implemented in a reliable manner
#   for all cases, so only two scenarios are considered - if the first argument
#   is a string literal and if the second argument is an array literal.
