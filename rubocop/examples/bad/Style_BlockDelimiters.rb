# 'https://github.com/bbatsov/ruby-style-guide#single-line-blocks'

# Prefer {...} over do...end for single-line blocks.
#   Avoid using {...} for multi-line blocks (multiline chaining is always ugly).
#   Always use do...end for "control flow" and "method definitions" (e.g.
#   in Rakefiles and certain DSLs). Avoid do...end when chaining.

names = %w(Bozhidar Steve Sarah)

# bad
names.each do |name|
  puts name
end

# bad
names.select do |name|
  name.start_with?('S')
end.map { |name| name.upcase }
