##Ruby コーデング規約（標準スタイル編）

####レイアウト

#####エンコーディング
* UTF-8以外は使用しない。

* 基本的にスクリプトエンコーディングのマジックコメントが必要なソースコードにしない。

**理由**

* UTF-8がcomputer/webの世界で事実上の標準エンコードであるため。

* 2バイト文字は基本的にユーザーのために記述するものであり、それはソースコードに埋め込まれずにlocaleファイル等に記述されるべきものであるため。


#####基本
* インデントはホワイトスペース2個
* ハードタブは使用しない
* 1行の文字数は80文字以下にする
* 行の最後に無駄なホワイトスペースは付けない
* 演算子の前後、コロンの前後、カンマの後ろとセミコロンの後ろににホワイトスペースを1個置く
* カンマ、セミコロンの前にはホワイトスペースは置かない

```ruby
sum = 1
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'
```

* [] () {} 全ての前後にホワイトスペースは置かない

```ruby
a = [1, 2, 3] #"[" の左のスペースは = の後ろのもの
[1, 2, 3].each{|num| puts num * 2}
def method(a, b, c)
```

* 仮引数の後にホワイトスペースを入れる

```ruby
# good
arr.each{|elem| puts elem}

# bad
arr.each{|elem|puts elem}
```

* ``` do ``` と仮引数の間にホワイトスペースを入れる

```ruby
# good
arr.each do |elem|
  puts elem
end

# bad
arr.each do|elem|
  puts elem
end
```

* コメントアウトの ``` # ``` の後にはホワイトスペースを置く

```ruby
#this is bad comment

# this is good comment
```

* コメントアウトの ``` =begin ``` の行には何も書いてはいけない

```ruby
=begin # bad style
  do
    somthing
  end
=end

=begin
# good style
  do
    somthing
  end
=end
```

* ``` when ``` と ``` case ``` のインデントは同じ深さにする

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

* ``` def ``` の後には空行を入れる。

```ruby
def method1
  # some proccesses
end

def some_method2
  # some proccesses
end
```

####文法

* メソッドの定義には ``` () ``` を使わない

```ruby
def method1
  # some proccesses
end

def method2 arg1, arg2
  # some proccesses
end  
```

* ``` for ``` は使用禁止

```ruby
arr = [1, 2, 3]

# bad
for elem in arr do
  puts elem
end

# good
arr.each{|elem| puts elem}
```

* ``` then ``` は使用禁止

```ruby
# bad
if some_condition then
  # some proccesses
end

# good
if some_condition
  # some proccesses
end
```

* 三項演算子（ ``` ? :  ```）を使って良いのは1行で全てが納まる時のみとし、その場合は ``` if then else ``` を使わない。

```ruby
# good
weather = sun.shiny? ? 'well' : 'cloud'

# bad
weather = sun.shin? ?
  'well'
  :
  'cloud'

# bad
weather = if sun.shiny? then 'well' else 'cloud' end # you must also not use 'then' keyword.
```

* 三項演算子を重ねて利用してはいけない

```ruby
# bad
some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

# good
if some_condition
  nested_condition ? nested_something : nested_something_else
else
  something_else
end
```

* ``` and ``` と ``` or ``` は ``` && ``` と ``` || ``` で代用できる場合は代用する

* 1行で ``` if 〜 end ``` が納まる場合は後置にする

```ruby
# bad
if some_condition
  do_something
end

# good
do_something if some_condition
```

* ``` unless ``` は ``` else ``` と共に使ってはいけない

```ruby
# bad
unless success?
  puts 'failure'
else
  puts 'success'
end

# good
if success?
  puts 'success'
else
  puts 'failure'
end
```

* ``` if/unless/while ``` の条件に ``` ()  ``` は使わない

```ruby
# bad
if (x > 10)
  # body omitted
end

# good
if x > 10
  # body omitted
end
```

* 1行で納まるblockは ``` {} ``` を使う。そうでない場合は ``` do 〜 end ``` を使う。method chain する場合もこのルールに従う。

``` ruby
names = ["Bozhidar", "Steve", "Sarah"]

# good
names.each{|name| puts name}

# bad
names.each do |name|
  puts name
end

# good
[1, 2, 3].map{|num| num * 2}.reduce{|double, sum| sum += double}

# also good
[1, 2, 3].map do |num|
  num * 2
end.reduce do |double, sum|
  sum += double
end
```

* ``` return ``` は省略できる場合は省略する

``` ruby
# bad
def some_method(some_arr)
  return some_arr.size
end

# good
def some_method(some_arr)
  some_arr.size
end
```

* ``` if ``` の条件式を代入する場合、``` () ``` でくくる

```ruby
# good
if (v = array.grep(/foo/)) ...

# bad
if v = array.grep(/foo/) ...

# also good - has correct precedence.
if (v = next_value) == "hello" ...
```

**理由**

``` == ``` メソッドとの混同を防ぐため

