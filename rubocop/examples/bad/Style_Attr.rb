# 'https://github.com/bbatsov/ruby-style-guide#attr'

# Avoid the use of attr. Use attr_reader and attr_accessor instead.

# bad - creates a single attribute accessor
attr :something, true
attr :one, :two, :three # behaves as attr_reader
