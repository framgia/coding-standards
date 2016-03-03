# Prefer proc.call() over proc[] or proc.() for both lambdas and procs.

# bad - looks similar to Enumeration access
l = ->(v) { puts v }
l[1]

# also bad - uncommon syntax
l = ->(v) { puts v }
l.(1)
