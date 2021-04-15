# Prefer proc over Proc.new.

# bad
p = Proc.new { |n| puts n }
