# Don't do explicit non-nil checks unless you're dealing with boolean values.

# good
do_something if something

# good - dealing with a boolean
def value_set?
  !@some_boolean.nil?
end
