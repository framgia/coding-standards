# 'https://github.com/bbatsov/ruby-style-guide#no-character-literals'

# Don't use the character literal syntax ?x.
#   Since Ruby 1.9 it's basically redundant - ?x would interpreted as 'x'
#   (a string with a single character in it).

# bad
char = ?c
