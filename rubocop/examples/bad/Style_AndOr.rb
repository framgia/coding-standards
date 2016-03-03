# 'https://github.com/bbatsov/ruby-style-guide#no-and-or-or'

# The and and or keywords are banned.
# It's just not worth it. Always use && and || instead.

# bad
# boolean expression
if some_condition and some_other_condition
  do_something
end

# control flow
document.saved? or document.save!
