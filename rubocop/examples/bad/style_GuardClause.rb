# This cop if/unless expression that can be replace with a guard clause.
# It should be extended to handle methods whose body
#   is if/else or a case expression with a default branch.

# bad
def test
  if something
    work
    work
    work
  end
end
