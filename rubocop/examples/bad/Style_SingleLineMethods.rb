# Avoid single-line methods. Although they are somewhat popular in the wild,
#   there are a few peculiarities about their definition syntax
#   that make their use undesirable. At any rate - there should be no
#   more than one expression in a single-line method.

# bad
def too_much; something; something_else; end

# okish - notice that the first ; is required
def no_braces_method; body end

# okish - notice that the second ; is optional
def no_braces_method; body; end

# okish - valid syntax, but no ; makes it kind of hard to read
def some_method() body end
