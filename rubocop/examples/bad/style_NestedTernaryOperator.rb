# Use one expression per branch in a ternary operator.
#   This also means that ternary operators must not be nested.
#   Prefer if/else constructs in these cases. [link]

# bad
some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else
