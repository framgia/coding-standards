# This cop looks for inject / reduce calls where the passed
#   in object is returned at the end and so could be replaced
#   by each_with_object without the need to return the object at the end.

# However, we can't replace with each_with_object
#   if the accumulator parameter is assigned to within the block.

# good
[1, 2].each_with_object({}) { |e, a| a[e] = e }
