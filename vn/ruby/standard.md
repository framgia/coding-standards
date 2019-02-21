# Các quy dịnh về viết code Ruby (Tập các kiểu chuẩn)

## Giao diện (Layout)

## Mã hóa (Encoding)
* Chỉ sử dụng UTF-8

* Về cơ bản, không viết các source code yêu cầu các chú thích mã hóa script

**Lý do**

* Vì UTF-8 là một mã hóa tiêu chuẩn trên thực tế trong thế giới của máy tính / web.

* Vì các ký tự hai byte về cơ bản để dùng cho người sử dụng, nên không nên nhúng chúng trong mã nguồn mà nên được mô tả trong các tập tin locale.

## Các chuẩn cơ bản
* Lề (indent) là 2 khoảng trắng (white space)
* Không dùng tab
* Không để khoảng trắng ở cuối dòng
* Trước và sau các toán tử, dấu hai chấm, sau dấu phẩy và dấu chấm phẩy, để 1 khoảng trắng.
* Trước dấu phẩy và dấu chấm phẩy không để khoảng trắng.

```ruby
sum = 1
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'
```

* Trong một dòng không viết quá 80 kí tự
* Nếu dài hơn 80 kí tự thì xuống dòng mới theo quy tắc sau.
  * Nếu xuống dòng khi đang ở giữa chuỗi method thì xuống dòng trước dấu ``` . ``` （dot) và đem dấu chấm xuống đầu dòng mới

  ```ruby
    "one string".something_long_long_method(arg1)
      .other_cool_long_method(arg2)
      .another_awsome_long_method(arg3)
  ```

  * Nếu xuống dòng khi định nghĩa method thì để tránh xảy ra lỗi Syntax Error nên dùng ``` () ```

  ```ruby
    def long_method_name(parameter_1, parameter_2, parameter_3, parameter_4,
      parameter_5, parameter_6, options)
  ```

Cho phép 1 dòng có quá 80 ký tự trong trường hợp nguyên nhân là do chuỗi string literal dài.

  ```ruby
  # ok
  foo = "This is a very very long string that can't be broken down and may contain #{variable}"
  ```

* Trước và sau các dấu [] () {} không để khoảng trắng

```ruby
a = [1, 2, 3] #Khoảng trắng bên trái của ký tự "[" là khoảng trắng theo sau của dấu = (chứ không phải là khoảng trắng đặt trước của ký tự "[")
[1, 2, 3].each{|num| puts num * 2}
def method(a, b, c)
```

* Sử dụng here document với chuỗi string dài có bao gồm xuống dòng. 
 Tuy nhiên, cho phép sử dụng string literal khi định nghĩa đoạn message ngắn hoặc dùng method chain.
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

* Đặt khoảng trắng vào sau các đối số

```ruby
# Cách viết đúng
arr.each{|elem| puts elem}

# Cách viết không đúng
arr.each{|elem|puts elem}
```

* Hash về cơ bản được viết theo quy ước viết tắt của phiên bản 1.9

```ruby
# Cách viết không đúng
h = {:key => :value}

# Cách viết đúng
h = {key: :value}
```

* Giữa ``` do ``` và đối số đặt 1 khoảng trắng

```ruby
# Cách viết đúng
arr.each do |elem|
  puts elem
end

# Cách viết không đúng
arr.each do|elem|
  puts elem
end
```

* Sau ký tự comment out ``` # ``` đặt 1 khoảng trắng

```ruby
#this is bad comment

# this is good comment
```

* Không được viết gì ở dòng comment out ``` =begin ```

```ruby
=begin # Cách viết không đúng style
  do
    something
  end
=end

=begin
# Cách viết đúng style
  do
    something
  end
=end
```

* Để lề của``` when ``` và ``` case ``` như nhau

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

* Tuy nhiên, trong trường hợp ở bên trái của ```case``` có gì đó, thì indent của dòng có ```when``` lùi vào một khoảng so với dòng của ```case```.
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

* Sau ``` def ``` đặt 1 khoảng trắng

```ruby
def method1
  # some proccesses
end

def some_method2
  # some proccesses
end
```

## Các tiêu chuẩn về ngữ pháp

* Không sử dụng ``` () ``` trong định nghĩa method, Thế nhưng trong trường hợp dưới đây có thể dùng ``` () ```
  * Tham số của method quá nhiều nên xuống dòng để đảm bảo không quá 80 kí tự.

```ruby
def method1
  # some proccesses
end

def method2 arg1, arg2
  # some proccesses
end
```

* Không dùng ``` () ``` khi gọi các method. Thế nhưng vẫn có thể dùng trong các trường hợp dưới đây.
  * Có các toán tử bên trong tham số. Hoặc là có toán tử ngay sau method. Hoặc tham số là hash.
  * Có từ 2 tham số trở lên.
  * Tham số của method quá nhiều nên phải xuống dòng để đảm bảo không quá 80 kí tự.

* Không được dùng ``` for ```

```ruby
arr = [1, 2, 3]

# Cách viết không đúng
for elem in arr do
  puts elem
end

# Cách viết đúng
arr.each{|elem| puts elem}
```

* Không được dùng ``` then ```

```ruby
# Cách viết không đúng
if some_condition then
  # some proccesses
end

# Cách viết đúng
if some_condition
  # some proccesses
end
```

* Khi sử dụng toán tử 3 điều kiện （ ``` ? :  ```）, phải viết tất cả các thành phần lệnh trên 1 dòng
và trong trường hợp này không dùng ``` if then else ```

```ruby
# Cách viết đúng
weather = sun.shiny? ? 'well' : 'cloud'

# Cách viết không đúng
weather = sun.shin? ?
  'well'
  :
  'cloud'

# Cách viết không đúng
weather = if sun.shiny? then 'well' else 'cloud' end # you must also not use 'then' keyword.
```

* Không được sử dụng các toán tử 3 điều kiện lồng nhau

```ruby
# Cách viết không đúng
some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

# Cách viết đúng
if some_condition
  nested_condition ? nested_something : nested_something_else
else
  something_else
end
```

* Khi có thể dùng ``` && ``` và ``` || ``` thay thế ``` and ``` và ``` or ``` thì nên dùng.

*  ``` if 〜 end ``` hoặc ``` unless 〜 end ``` có thể được giản lược bằng cách đặt ``` if ``` hoặc ``` unless ``` xuống cuối câu.
* Sử dụng thể giản lược khi có thể viết câu trên cùng 1 dòng tối đa 80 ký tự.

```ruby
# Cách viết không đúng
if some_condition
  foo = "This is a short string"
end

# Cách viết đúng
foo = "This is a short string" if some_condition

# Cách viết không đúng
foo = "This is a very very long string that can not be broken down and may contain #{variable}" unless some_condition

# Cách viết đúng
unless some_condition
  foo = "This is a very very long string that can not be broken down and may contain #{variable}"
end
```

* Không được dùng ``` unless ``` với ``` else ```

```ruby
# Cách viết không đúng
unless success?
  puts 'failure'
else
  puts 'success'
end

# Cách viết đúng
if success?
  puts 'success'
else
  puts 'failure'
end
```

*  Không sử dụng phép toán phủ định ``` ! ``` trong câu điều kiện ``` if ``` (nếu cần thiết thì dùng ``` unless ```). Thế nhưng chúng ta vẫn có thể dùng trong trường hợp kết hợp với ``` && ``` hoặc ``` || ```. Trong những trường hợp này chúng ta có thể áp dụng các luật De Morgan để viết đơn giản hơn.

```ruby
# cách viết không tốt
if !user.nil?
  user.greeting
end

# cách viết tốt
unless user.nil?
  user.greeting
end

# cách viết rất tốt
if user
  user.greeting
end

# cách viết rất tốt
user.greeting if user

# OK
if !user.nil? && !user.suspended?
  user.greeting
end

# cách viết không tồi nhưng mà hơi phức tạp
unless user.nil? || user.suspended?
  user.greeting
end

# nên viết thế này
if user && user.active?
  user.greeting
end
```

* Không đặt dấu  ``` ()  ``` trong các điều kiện của các lệnh ``` if/unless/while

```ruby
# Cách viết không đúng
if (x > 10)
  # body omitted
end

# Cách viết đúng
if x > 10
  # body omitted
end
```

* Nếu có 1 lệnh block thì dùng``` {} ``` và viết trên 1 dòng.
Trường hợp có nhiều lệnh gộp thì dùng ``` do 〜 end ```
Rule này cũng áp dụng cho trường hợp method chain.

``` ruby
names = ["Bozhidar", "Steve", "Sarah"]

# Cách viết đúng
names.each{|name| puts name}

# Cách viết không đúng
names.each do |name|
  puts name
end

# Cách viết đúng
[1, 2, 3].map{|num| num * 2}.reduce{|double, sum| sum += double}

# also good
[1, 2, 3].map do |num|
  num * 2
end.reduce do |double, sum|
  sum += double
end
```

* Trong trường hợp có thể bỏ được ``` return ``` thì bỏ

``` ruby
# Cách viết không đúng
def some_method(some_arr)
  return some_arr.size
end

# Cách viết đúng
def some_method(some_arr)
  some_arr.size
end
```

* Trong trường hợp có phép gán trong biểu thức điều kiện ``` if ``` thì sử dụng dấu ``` () ```

```ruby
# Cách viết đúng
if (v = array.grep(/foo/)) ...

# Cách viết không đúng
if v = array.grep(/foo/) ...

# Cách viết cũng đúng - theo đúng thứ tự ưu tiên
if (v = next_value) == "hello" ...
```

**Lý do**

* Để tránh nhầm lẫn với method ``` == ```

* Khuyến khích sử dụng cách khởi tạo biến ``` ||= ```.
Tuy nhiên, với biến boolean, cần chú ý là giá trị false sẽ bị ghi đè

```ruby
# Thiết lập name là Bozhidar, chỉ khi name là nil hoặc false
name ||= 'Bozhidar'

# Cách viết không đúng - sẽ set enabled là true ngay cả khi nó là false
enabled ||= true

# Cách viết đúng
enabled = true if enabled.nil?
```

* Giữa tên của method và đối số, không chèn khoảng trắng

```ruby
# Cách viết không đúng
f (3 + 2) + 1

# Cách viết đúng
f(3 + 2) + 1
```

* Không dùng đối số trong block, dùng ``` _ ```

```ruby
# Cách viết không đúng
result = hash.map {|k, v| v + 1}

# Cách viết đúng
result = hash.map {|_, v| v + 1}
```

* Dùng từ giản lược của tên đối số để đặt tên cho đối số tạm thời trong block

```ruby
# Cách viết đúng
products.each {|product| product.maintain!}

# OK
products.each {|prod| prod.maintain!}
```

* Trong trường hợp tạo biến số như Mảng rỗng hay Hash rỗng thì dùng ``` Array.new ```, ``` Hash.new ```.

```ruby
#Cách viết không đúng
  @users = []

#Cách viết đúng
  @users = Array.new

#Cũng đúng
  @months_of_birth_date = User.all.inject([]){|months, user| months << user.birth_date.month}
```

**Lý do**

Thể hiện rõ ý đồ tạo object mới, nên nhìn vào dễ hiểu hơn.

## Cách đặt tên

* Tên method hoặc biến số thì dùng ``` snake_case ```

* Tên class hoặc module thì dùng ``` CamelCase ```

* Hằng số tổng quát dùng ``` SCREAMING_SNAKE_CASE ```

* Các method trả về giá trị boolean thì thêm dấu ? ở cuối như ``` Array#empty? ```

* Các method hủy hoặc method nguy hiểm thì đặt ``` ! ``` ở cuối như ``` Array#flatten! ```
Khi định nghĩa method hủy, method không hủy như ``` Array#flatten ``` cũng được định nghĩa.

## Class

* Trácnh sử dụng biến class ``` @@ ``` trừ khi thực sự cần thiết

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

Parent.print_class_var # => sẽ hiển thị "child"
```

* Kiểm tra xem biến class instance có thực hiện được không ?

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

Parent.print_class_var # => sẽ hiển thị "parent"
```

* Khi định nghĩa singleton method (class method), không dùng ``` def self.method ``` hoặc ``` def ClassName.method ```

```ruby
class TestClass
  # Cách viết không đúng
  def TestClass.some_method
    # body omitted
  end

  # Cách viết không đúng
  def self.some_other_method
    # body omitted
  end
end
```

* Khi định nghĩa 1 method hoặc một class macro cụ thể, dùng ``` class << self ```

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

* Với block những public methods, thì ko cần khai báo ``` public ``` ở trước như cách làm với các block private/protected bên dưới.

* Viết ``` protected ``` methods trước ``` private ``` methods. Lúc đó, khi định nghĩa các protected, private method, căn lề trùng với public method và đặt dòng trắng trên các protected, private methods này, không đặt dòng trắng ở bên dưới.

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

* Ngoài lúc gọi các private method, lúc để chỉ chính các hàm này, dùng ``` self ```

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

## Ngoại lệ

* Không dùng ngoại lệ để kiểm soát flow, những ngoại lệ có thể tránh được thì nên tránh.大域脱出には ``` throw / catch ``` を利用してよい

**Lý do**

Khi mà phát sinh ngoại lệ thì tốn nhiều chi phí để tạo ra StackTrace. Trong xử lý bình thường thì cần tránh việc tạo ra StackTrace.

```ruby
# Cách viết không đúng
begin
  n / d
rescue ZeroDivisionError
  puts "Cannot divide by 0!"
end

# Cách viết đúng
if d.zero?
  puts "Cannot divide by 0!"
else
  n / d
end
```

* Không được ``` rescue ```  class ``` Exception ``` mà phải ``` rescue ``` một class cụ thể

```ruby
# Cách viết không đúng
begin
  # ngoại lệ xuất hiện ở đây
rescue
  # xử lý ngoại lệ
end

# Cách viết vẫn không đúng
begin
  # ngoại lệ xuất hiện ở đây
rescue Exception
  # xử lý ngoại lệ
end

# Cách viết đúng
begin
  # Ngoai lệ xuất hiện ở đây
rescue XxxException # phải chỉ định xử lý ngoại lệ cụ thể
  # xử lý ngoại lệ
end
```

* Khi tạo mảng từ chuỗi ký tự, nên tích cực sử dụng ``` %w( ) ```

```ruby
# Cách viết không đúng
STATES = ['draft', 'open', 'closed']

# Cách viết đúng
STATES = %w(draft open closed)
```

* Khi viết key của Hash, không dùng ký tự mà trong khả năng có thể sử dụng symbol

```ruby
# Cách viết không đúng
hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

# Cách viết đúng
hash = { one: 1, two: 2, three: 3 }
```

## Chuỗi ký tự

* Khi kết hợp các biến thành một chuỗi, không sử dụng ghép thông thường mà sử dụng khai triển

```ruby
# Cách viết không đúng
email_with_name = user.name + ' <' + user.email + '>'

# Cách viết đúng
email_with_name = "#{user.name} <#{user.email}>"
```
* Chỉ dùng dấu ``` ' ``` khi không có khai triển, dấu ``` " ``` và dấu `\` khi trong chuỗi kí tự.

```ruby
# Cách viết không đúng
name = 'Bozhidar'

# Cách viết đúng
name = "Bozhidar"
```

* Khi muốn thêm vào tiếp, không dùng method ``` String#+ ``` mà thay vào đó dùng method ``` String#<< ```

```ruby
# Cách viết đúng và cũng nhanh
html = ''
html << '<h1>Page title</h1>'

paragraphs.each do |paragraph|
  html << "<p>#{paragraph}</p>"
end
```

*Khi sử dụng here document, delimiter được căn lề thẳng với lệnh gán.

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
#...lược bỏ
```

## Biểu thức chính quy

* Không dùng ```  $1 〜 9 ```Gán tên cho chuỗi ký tự ví dụ phù hợp

```ruby
# Cách viết không đúng
/(regexp)/ =~ string
...
process $1

# Cách viết đúng
/(?<meaningful_var>regexp)/ =~ string
...
process meaningful_var
```

* Khi muốn xác định bắt đầu và kết thúc của một chuỗi bao gồm cả các dòng mới, sử dụng ``` \A ``` và ``` \Z ```

```ruby
string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\Z/] # don't match
```

* Tích cực sử dụng tùy chọn ``` x ``` khi viết một mẫu biểu thức chính quy phức tạp.
Tuy nhiên, khi áp dụng cần lưu ý là các ký tự trống bị bỏ qua.

```ruby
regexp = %r{
  start         # some text
  \s            # white space char
  (group)       # first group
  (?:alt1|alt2) # some alternation
  end
}x
```

## Kí pháp phần trăm

* Sử dụng ``` %() ``` khi cần hiển thị chính kí tự ``` " ```

```ruby
message = %(chú ý phân biệt ' và ")
```

* ``` %r() ``` được dùng khi trong các biểu thức chính quy, cần phải viết dấu ``` / ```

```ruby
# Cách viết không đúng
%r(\s+)

# Cách viết vẫn không đúng
%r(^/(.*)$)
# nên viết là /^\/(.*)$/

# Cách viết đúng
%r(^/blog/2011/(.*)$)
```

## So sánh giá trị

* Khi so sánh biến số với một giá trị khác như số thực hay hằng số thì viết biến số sang bên phải

```ruby
greeting = "Hello!"

# Cách viết không tốt
if greeting == "Hola!"
  ...
end

# Cách viết tốt
if "Hola!" == greeting
  ...
end
```

** Lý do **

Khi mà nhầm `==` thành bằng `=` thì phép so sánh sẽ không được gán mà trả về SyntaxError

## Date format
Để format phần năm của ngày tháng dưới dạng `yyyy`, sử dụng `%Y`.

## Vấn đề khác

* Không dùng ``` __END___ ```
