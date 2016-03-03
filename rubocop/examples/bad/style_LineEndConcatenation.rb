# This cop checks for string literal concatenation at the end of a line.


# bad
some_str = 'ala' +
           'bala'

some_str = 'ala' <<
           'bala'
