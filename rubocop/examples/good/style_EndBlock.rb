# Do not use END blocks. Use Kernel#at_exit instead.

# good
at_exit { puts 'Goodbye!' }
