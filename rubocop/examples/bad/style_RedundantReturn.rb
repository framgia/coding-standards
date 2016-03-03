# Avoid return where not required for flow of control.

# bad
def some_method(some_arr)
  return some_arr.size
end
