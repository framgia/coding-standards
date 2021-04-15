# 'https://github.com/bbatsov/ruby-style-guide#consistent-multi-line-chains'

# Adopt a consistent multi-line method chaining style.
#   There are two popular styles in the Ruby community,
#   both of which are considered good - leading . (Option A) and
#   trailing . (Option B).

# (Option A) When continuing a chained method invocation
#   on another line keep the . on the second line.

# bad - need to consult first line to understand second line
one.two.three.
  four

# (Option B) When continuing a chained method invocation on another line,
#   include the . on the first line to indicate that the expression continues.

# bad - need to read ahead to the second line to know that the chain continues
one.two.three
  .four
