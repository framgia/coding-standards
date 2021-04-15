# Don't use the cryptic Perl-legacy variables denoting last regexp group matches
#   ($1, $2, etc). Use Regexp.last_match(n) instead.

/(regexp)/ =~ string
...

# bad
process $1
