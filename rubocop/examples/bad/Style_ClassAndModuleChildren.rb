# TODO:This cop checks the style of children definitions at classes and modules.
#   Basically there are two different styles:
#   nested - have each child on its own line

# bad
class Foo
  class Bar
  end
end
