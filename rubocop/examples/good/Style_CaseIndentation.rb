# 'https://github.com/bbatsov/ruby-style-guide#indent-when-to-case'

# Indent when as deep as case.
# This is the style established in both "The Ruby Programming Language"
# and "Programming Ruby".

# good
case
when song.name == 'Misty'
  puts 'Not again!'
when song.duration > 120
  puts 'Too long!'
when Time.now.hour > 21
  puts "It's too late"
else
  song.play
end
