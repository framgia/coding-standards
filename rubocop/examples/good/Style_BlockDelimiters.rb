# 'https://github.com/bbatsov/ruby-style-guide#single-line-blocks'

# Prefer {...} over do...end for single-line blocks.
# Avoid using {...} for multi-line blocks (multiline chaining is always ugly).
# Always use do...end for "control flow" and "method definitions" (e.g.
# in Rakefiles and certain DSLs). Avoid do...end when chaining.

names = %w(Bozhidar Steve Sarah)

# good
names.each { |name| puts name }

# good
names.select { |name| name.start_with?('S') }.map(&:upcase)
