# 'https://github.com/bbatsov/ruby-style-guide#no-and-or-or'

# The and and or keywords are banned.
# It's just not worth it. Always use && and || instead.

# good
# boolean expression
if some_condition && some_other_condition
  do_something
end

# control flow
document.saved? || document.save!
