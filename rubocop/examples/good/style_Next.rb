# Use `next` to skip iteration instead of a condition at the end.

# good
[1, 2].each do |a|
  next unless a == 1
  puts a
end
