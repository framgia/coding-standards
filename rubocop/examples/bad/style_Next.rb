# Use `next` to skip iteration instead of a condition at the end.

# bad
[1, 2].each do |a|
  if a == 1 do
    puts a
  end
end
