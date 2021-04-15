# Do not use END blocks. Use Kernel#at_exit instead.

# bad
END { puts 'Goodbye!' }
