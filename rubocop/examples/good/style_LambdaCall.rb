# Prefer proc.call() over proc[] or proc.() for both lambdas and procs.

# good
l = ->(v) { puts v }
l.call(1)
