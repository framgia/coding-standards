# Don't do explicit non-nil checks unless you're dealing with boolean values.

# bad
do_something if !something.nil?
do_something if something != nil
