# 'https://github.com/bbatsov/ruby-style-guide#consistent-multi-line-chains'

# Adopt a consistent multi-line method chaining style.
#   There are two popular styles in the Ruby community,
#   both of which are considered good - leading . (Option A) and
#   trailing . (Option B).

# (Option A) When continuing a chained method invocation
#   on another line keep the . on the second line.

# good - it's immediately clear what's going on the second line
one.two.three
  .four

# (Option B) When continuing a chained method invocation on another line,
#   include the . on the first line to indicate that the expression continues.

# good - it's immediately clear that the expression
#   continues beyond the first line
one.two.three.
  four

