# Favor unless over if for negative conditions (or control flow ||).

# good
do_something unless some_condition

# another good option
some_condition || do_something
