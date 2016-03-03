# TODO: This cop checks for redundant uses of `self`.

# `self` is only needed when:
#   Sending a message to same object with zero arguments in presence of a method
#   name clash with an argument or a local variable.
#   Note, with using explicit self you can only send messages with public
#   or protected scope, you cannot send private messages this way.
