# Rules about writing Ruby code (Standard)

## Layout

## Encoding
* Use UTF-8 only

* Basically, do not write code that need encoding script comments

**Reason**

* UTF-8 is a standard encoding globally.

* 2-bytes characters should not be in source code, they should be in locale files.


## Basic
* Indentation is 2 white spaces
* Do not use tab
* Do not leave trailing white spaces
* Add 1 white space before and after operators, colon (:), and after comma (,), semi-colon (;)
* Do not add white spaces before comma (,) and semi-colon(;)


```ruby
sum = 1
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'
```

* Do not write more than 80 characters in a line
* If the line is more than 80 characters, break to a new line following below rules
  * If it is a string of methods, break line before dot ``` . ``` and let the dot ``` . ``` be the start of new line

  ```ruby
    "one string".something_long_long_method(arg1)
      .other_cool_long_method(arg2)
      .another_awsome_long_method(arg3)
  ```

  * If it is method definition, use ``` () ``` to avoid syntax error

  ```ruby
    def long_method_name(parameter_1, parameter_2, parameter_3, parameter_4,
      parameter_5, parameter_6, options)
  ```

A line can be more than 80 characters in case it is a long leteral string.

  ```ruby
  # ok
  foo = "This is a very very long string that can't be broken down and may contain #{variable}"
  ```

* Do not add white spaces before and after [] () {}

```ruby
a = [1, 2, 3] #The white space left of `[` is the white space following `=`, not the white space before `[`
[1, 2, 3].each{|num| puts num * 2}
def method(a, b, c)
```

* Use here document for long string with line breaks.
However, we can use literal string when define a short message or method chain.

```ruby
  # good
      foo = <<-EOS
From this valley they say you are going,
We will miss your bright eyes and sweet smile,
For they say you are taking the sunshine
That has brightened our pathways a while.
      EOS

  # ok
      foo = "Hi, Johnny.
How are you?"

  # bad
      foo = "From this valley they say you are going,\nWe will miss your bright eyes and sweet smile,\nFor they say you are taking the sunshine\nThat has brightened our pathways a while."
```

* Add 1 white space after arguments.

```ruby
# correct
arr.each{|elem| puts elem}

# incorrect
arr.each{|elem|puts elem}
```

* Write hash in 1.9 style

```ruby
# incorrect
h = {:key => :value}

# correct
h = {key: :value}
```

* Add 1 white space between ``` do ``` and argument

```ruby
# correct
arr.each do |elem|
  puts elem
end

# incorrect
arr.each do|elem|
  puts elem
end
```

* Add 1 white space after comment out character ``` # ```

```ruby
#this is a bad comment

# this is a good comment
```

* Do not write anything in line comment out ``` =begin ```

```ruby
=begin # incorrect
  do
    something
  end
=end

=begin
# correct
  do
    something
  end
=end
```

* Let indentation of ``` when ``` and ``` case ``` be the same

```ruby
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
```

* Howerver, if left side of ``` case ``` has anything, indentation of ``` when ``` lines will be inside compare with ``` case ```.
```ruby
foo = case
  when song.name == 'Misty'
    puts 'Not again!'
  when song.duration > 120
    puts 'Too long!'
  when Time.now.hour > 21
    puts “It's too late”
  else
    song.play
  end
```

* Add 1 white space after ``` def ```

```ruby
def method1
  # some proccesses
end

def some_method2
  # some proccesses
end
```

## Syntax

* Do not use ``` () ``` in method definition
  * If parameters of method are too many, break them into new lines to ensure a line has less than 80 characters. In that case we should use ``` () ``` to avoid syntax error.

```ruby
def method1
  # some proccesses
end

def method2 arg1, arg2
  # some proccesses
end
```

* Do not use ``` () ``` when calling method. However we can use in below cases
  * There are operators in parameters, or operators right after method, or paremeter is hash
  * Has 2 or more parameters
  * There are too many parameters, the line will break to a new line so there are less than 80 characters.

* Do not use ``` for ```

```ruby
arr = [1, 2, 3]

# incorrect
for elem in arr do
  puts elem
end

# correct
arr.each{|elem| puts elem}
```

* Do not use ``` then ```

```ruby
# incorrect
if some_condition then
  # some proccesses
end

# correct
if some_condition
  # some proccesses
end
```

* When using ternary operator / conditional operator ( ``` ? :  ``` ), all should be written on the same line. Do not use ``` if then else ```

```ruby
# correct
weather = sun.shiny? ? 'well' : 'cloud'

# incorrect
weather = sun.shin? ?
  'well'
  :
  'cloud'

# incorrect
weather = if sun.shiny? then 'well' else 'cloud' end # you must also not use 'then' keyword.
```

* Do not use nested ternary operators

```ruby
# incorrect
some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

# correct
if some_condition
  nested_condition ? nested_something : nested_something_else
else
  something_else
end
```

* Use ``` && ``` and ``` || ``` instead of ``` and ``` and ``` or ``` if possible

* ``` if ~ end ``` or ``` unless ~ end ``` can be shorten by putting ``` if ``` or ``` unless ``` at the end of line
* Use short style when it is possible to write less than 80 characters in a line

```ruby
# incorrect
if some_condition
  foo = "This is a short string"
end

# correct
foo = "This is a short string" if some_condition

# incorrect
foo = "This is a very very long string that can not be broken down and may contain #{variable}" unless some_condition

# correct
unless some_condition
  foo = "This is a very very long string that can not be broken down and may contain #{variable}"
end
```

* Do not use ``` unless ``` with ``` else ```

```ruby
# incorrect
unless success?
  puts 'failure'
else
  puts 'success'
end

# correct
if success?
  puts 'success'
else
  puts 'failure'
end
```

* Do not use ``` ! ``` in ``` if ``` conditional clause (if necessary use ``` unless ```). However we can still use ``` ! ``` with ``` && ``` or ``` || ```.
In these cases we can use De Morgan's rules to write simpler.

```ruby
# bad
if !user.nil?
  user.greeting
end

# good
unless user.nil?
  user.greeting
end

# better
if user
  user.greeting
end

# better
user.greeting if user

# OK
if !user.nil? && !user.suspended?
  user.greeting
end

# OK but too complex
unless user.nil? || user.suspended?
  user.greeting
end

# should write like this
if user && user.active?
  user.greeting
end
```

* Do not use  ``` ()  ``` in conditional clause of ``` if/unless/while ```

```ruby
# incorrect
if (x > 10)
  # body omitted
end

# correct
if x > 10
  # body omitted
end
```

* If there is a code block, use ``` {} ``` and write in 1 line.
In case there are many commands, use ``` do ~ end ```
This rule also applies to method chain.

``` ruby
names = ["Bozhidar", "Steve", "Sarah"]

# correct
names.each{|name| puts name}

# incorrect
names.each do |name|
  puts name
end

# correct
[1, 2, 3].map{|num| num * 2}.reduce{|double, sum| sum += double}

# also good
[1, 2, 3].map do |num|
  num * 2
end.reduce do |double, sum|
  sum += double
end
```

* Remove ``` return ``` if possible

``` ruby
# incorrect
def some_method(some_arr)
  return some_arr.size
end

# correct
def some_method(some_arr)
  some_arr.size
end
```

* If there is assignment inside conditional clause of ``` if ```, use ``` () ```

```ruby
# correct
if (v = array.grep(/foo/)) ...

# incorrect
if v = array.grep(/foo/) ...

# also correct - follow priority order
if (v = next_value) == "hello" ...
```

**Reason**

* Avoid misunderstanding with ``` == ```

* Encourage using ``` ||= ``` for variable declaration
However, with boolean variables, false value will be overwritten

```ruby
# Assign name to be Bozhidar, only when name is nil or false
name ||= 'Bozhidar'

# incorrect - will set enabled to be true even when it is false
enabled ||= true

# correct
enabled = true if enabled.nil?
```

* There is no white spaces between method name and arguments

```ruby
# incorrect
f (3 + 2) + 1

# correct
f(3 + 2) + 1
```

* Do not use argument in block, use``` _ ```

```ruby
# incorrect
result = hash.map {|k, v| v + 1}

# correct
result = hash.map {|_, v| v + 1}
```

* Use shorten name of argument to name temporary argument in block

```ruby
# correct
products.each {|product| product.maintain!}

# OK
products.each {|prod| prod.maintain!}
```

* Create empty array or empty hash by using ``` Array.new ```, ``` Hash.new ```.

```ruby
# incorrect
  @users = []

# correct
  @users = Array.new

# also correct
  @months_of_birth_date = User.all.inject([]){|months, user| months << user.birth_date.month}
```

**Reason**

Clearly show intention of creating a new object

## Naming

* Method name or variable name use ``` snake_case ```

* Class name or Module name use ``` CamelCase ```

* Constant use ``` SCREAMING_SNAKE_CASE ```

* Methods which return boolean should add `?` at the end, such as ``` Array#empty? ```

* Destroy method or dangerous method should add `!` at the end, such as ``` Array#flatten! ```
When define destroy method, un-destroy method like ``` Array#flatten ``` should be defined as well.

## Class

* Avoid using class variables ``` @@ ``` unless it is really necessary

```ruby
class Parent
  @@class_var = 'parent'

  def self.print_class_var
    puts @@class_var
  end
end

class Child < Parent
  @@class_var = 'child'
end

Parent.print_class_var # => output "child"
```

* Check if class instance variable can be accessed

```ruby
class Parent
  @class_instance_var = 'parent'

  def self.print_class_instance_var
    puts @class_instance_var
  end
end

class Child < Parent
  @class_instance_var = 'child'
end

Parent.print_class_var # => output "parent"
```

* When define singleton method (class method), do not use ``` def self.method ``` or ``` def ClassName.method ```

```ruby
class TestClass
  # incorrect
  def TestClass.some_method
    # body omitted
  end

  # incorrect
  def self.some_other_method
    # body omitted
  end
end
```

* When define a method or a class macro, use ``` class << self ```

```ruby
class TestClass
  class << self
    attr_accessor :per_page
    alias_method :nwo, :find_by_name_with_owner

    def find_by_name_with_owner
      # body omitted
    end

    def first_method
      # body omitted
    end

    def second_method_etc
      # body omitted
    end
  end
end
```

* With a block of public methods, no need to declare ``` public ``` before like private/protected block below.

* Write ``` protected ``` methods before ``` private ``` methods. When define protected methods, private methods, indent the methods to be the same as public methods and add an empty line above these protected methods, private methods, do not add an empty line below.

```ruby
class SomeClass
  def public_method
    # ...
  end

  protected
  def protected_method
    # ...
  end

  private
  def private_method
    # ...
  end
end
```

* Use ``` self ``` to call these methods

```ruby
class SomeClass
  attr_accessor :message

  def set_name name
    self.message = "Hi #{name}"
  end

  def greeting
    puts self.message
  end
end
```

## Exception

* Do not use exception to control the flow. Exceptions which can be avoided should be avoided.

**Reason**

In normal process, avoid generating StackTrace of exceptions as much as possible.

```ruby
# incorrect
begin
  n / d
rescue ZeroDivisionError
  puts "Cannot divide by 0!"
end

# correct
if d.zero?
  puts "Cannot divide by 0!"
else
  n / d
end
```

* Do not ``` rescue ```  class ``` Exception ```. Must ``` rescue ``` a specific class

```ruby
# incorrect
begin
  # Exception caught
rescue
  # Process exception
end

# incorrect
begin
  # Exception caught
rescue Exception
  # Process exception
end

# correct
begin
  # Exception caught
rescue XxxException # Specify type of exceptions
  # Process exception
end
```

* Use ``` %w( ) ``` to create array of strings

```ruby
# incorrect
STATES = ['draft', 'open', 'closed']

# correct
STATES = %w(draft open closed)
```

* When write key of hash, use symbol instead of characters if possible

```ruby
# incorrect
hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

# correct
hash = { one: 1, two: 2, three: 3 }
```

## Strings

* When combine variables into a string, follow below rules

```ruby
# incorrect
email_with_name = user.name + ' <' + user.email + '>'

# correct
email_with_name = "#{user.name} <#{user.email}>"
```
* Use ``` " ``` and `\` for strings

```ruby
# incorrect
name = 'Bozhidar'

# correct
name = "Bozhidar"
```

* When need to add more into string, do not use ``` String#+ ``` method, use ``` String#<< ``` method

```ruby
# correct
html = ''
html << '<h1>Page title</h1>'

paragraphs.each do |paragraph|
  html << "<p>#{paragraph}</p>"
end
```

* When use here document, delimiter is indented the same as assign command

```ruby
module AttrComparable
  module ClassMethods
    def attr_comparable *attrs
      class_eval <<-DELIM
        attrs.each do |attr|
          define_method(attr.to_s<<'?'){|param| self.send(attr) == param }
        end
      DELIM
    end
  end
#...omitted
```

## Regular expression

* Do not use ```  $1 〜 9 ``` to name string

```ruby
# incorrect
/(regexp)/ =~ string
...
process $1

# correct
/(?<meaningful_var>regexp)/ =~ string
...
process meaningful_var
```

* To define start and end of a string, including new lines, use ``` \A ``` and ``` \Z ```

```ruby
string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\Z/] # don't match
```

* Use ``` x ``` when writing a complex regular expression. However, all empty characters will be ignored.

```ruby
regexp = %r{
  start         # some text
  \s            # white space char
  (group)       # first group
  (?:alt1|alt2) # some alternation
  end
}x
```

## % syntax

* Use ``` %() ``` when need to display ``` " ```

```ruby
message = %() (please differenate between ``` ' ``` and ``` " ```)
```

* Use ``` %r() ``` when need to write ``` / ``` in regular expression

```ruby
# incorrect
%r(\s+)

# incorrect
%r(^/(.*)$)
# should write as /^\/(.*)$/

# correct
%r(^/blog/2011/(.*)$)
```

## Comparison

* When need to compare between a variable and a value like a number or a constant, write variable on the right side

```ruby
greeting = "Hello!"

# bad
if greeting == "Hola!"
  ...
end

# good
if "Hola!" == greeting
  ...
end
```

**Reason**

If mistakenly write `==` to be `=`, the comparison will return SyntaxError

## Date format
To format the year part of a date as `yyyy`, use `%Y`.

## Others

* Do not use ``` __END___ ```
