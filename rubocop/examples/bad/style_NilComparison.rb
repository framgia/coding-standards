# Favor the use of predicate methods to explicit comparisons
#   with ==. Numeric comparisons are OK.

# bad
if x % 2 == 0
end

if x % 2 == 1
end

if x == nil
end
