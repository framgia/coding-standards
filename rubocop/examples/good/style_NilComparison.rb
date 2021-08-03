# Favor the use of predicate methods to explicit comparisons
#   with ==. Numeric comparisons are OK.

# good
if x.even?
end

if x.odd?
end

if x.nil?
end

if x.zero?
end

if x == 0
end
