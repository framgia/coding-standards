# 'https://github.com/bbatsov/ruby-style-guide#no-class-vars'

# TODO: Avoid the usage of class (@@) variables due to their "nasty"
#   behavior in inheritance.

# As you can see all the classes in a class hierarchy actually
#   share one class variable.
#   Class instance variables should usually be preferred over class variables.
