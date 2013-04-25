#Các quy dịnh về viết code Ruby (Tập các kiểu chuẩn)

##Giao diện (Layout)

##Mã hóa (Encoding)
* Chỉ sử dụng UTF-8

* Về cơ bản, không viết các source code yêu cầu các chú thích mã hóa script

**Lý do**

* Vì UTF-8 là một mã hóa tiêu chuẩn trên thực tế trong thế giới của máy tính / web.

* Vì các ký tự hai byte về cơ bản để dùng cho người sử dụng, nên không nên nhúng chúng trong mã nguồn mà nên được mô tả trong các tập tin locale.


##Các chuẩn cơ bản
* Lề (indent) là 2 khoảng trắng (white space)
* Không dùng tab
* Viết không quá 80 chữ trong một dòng lệnh
* Không để khoảng trắng ở cuối dòng
* Trước và sau các toán tử, dấu hai chấm, sau dấu phẩy và dấu chấm phẩy, để 1 khoảng trắng.
* Trước dấu phẩy và dấu chấm phẩy không để khoảng trắng.


```ruby
sum = 1
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'
```

* Trước và sau các dấu [] () {} không để khoảng trắng

```ruby
a = [1, 2, 3] #Khoảng trắng bên trái của ký tự "[" là khoảng trắng theo sau của dấu = (chứ không phải là khoảng trắng đặt trước của ký tự "[")
[1, 2, 3].each{|num| puts num * 2}
def method(a, b, c)
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

kind = case year
       when 1850..1889 then 'Blues'
       when 1890..1909 then 'Ragtime'
       when 1910..1929 then 'New Orleans Jazz'
       when 1930..1939 then 'Swing'
       when 1940..1950 then 'Bebop'
       else 'Jazz'
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

##Các tiêu chuẩn về ngữ pháp

* Không sử dụng ``` () ``` trong định nghĩa method

```ruby
def method1
  # some proccesses
end

def method2 arg1, arg2
  # some proccesses
end
```

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

* Nếu chỉ có 1 lệnh ``` if 〜 end ``` thì viết trên 1 dòng và để điều kiện ra phía sau.

```ruby
# Cách viết không đúng
if some_condition
  do_something
end

# Cách viết đúng
do_something if some_condition
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

##Cách đặt tên

* Tên method hoặc biến số thì dùng ``` snake_case ```

* Tên class hoặc module thì dùng ``` CamelCase ```

* Hằng số tổng quát dùng ``` SCREAMING_SNAKE_CASE ```

* Các method trả về giá trị boolean thì thêm dấu ? ở cuối như ``` Array#empty? ```

* Các method hủy hoặc method nguy hiểm thì đặt ``` ! ``` ở cuối như ``` Array#flatten! ```
Khi định nghĩa method hủy, method không hủy như ``` Array#flatten ``` cũng được định nghĩa.

##Class

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

* Không dùng ``` public ``` method

* Viết ``` protected ``` method trước ``` private ``` method. Lúc đó,khi định nghĩa các protected, private method, căn lề trùng với public method và đặt dòng trắng trên các protected 、 private method này, không đặt dòng trắng ở bên dưới.

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

##Ngoại lệ

* Không dùng Exception để kiểm soat flow, những Exception có thể tránh được thì không được sử dụng

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

* Với dấu ``` ' ``` thì nếu không có các lý do như "không dùng khai triển thức" hay "dấu``` " ```có mặt trong chuỗi ký tự" thì không dùng.

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

## Vấn đề khác

* Không dùng ``` __END___ ```
