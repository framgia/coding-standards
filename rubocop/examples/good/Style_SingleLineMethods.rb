# Avoid single-line methods. Although they are somewhat popular in the wild,
#   there are a few peculiarities about their definition syntax
#   that make their use undesirable. At any rate - there should be no
#   more than one expression in a single-line method.

# good
def some_method
  body
end
One exception to the rule are empty-body methods.

# good
def no_op; end
