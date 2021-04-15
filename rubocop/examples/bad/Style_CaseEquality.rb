# 'https://github.com/bbatsov/ruby-style-guide#no-case-equality'

# Avoid explicit use of the case equality operator ===.
#   As its name implies it is meant to be used implicitly by case expressions
#   and outside of them it yields some pretty confusing code.

# bad
Array === something
(1..100) === 7
/something/ === some_string
