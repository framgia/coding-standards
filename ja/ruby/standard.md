#Ruby コーデング規約（標準スタイル編）

##レイアウト

##エンコーディング
* UTF-8以外は使用しない。

* 基本的にスクリプトエンコーディングのマジックコメントが必要なソースコードにしない。

**理由**

* UTF-8がcomputer/webの世界で事実上の標準エンコードであるため。

* 2バイト文字は基本的にユーザーのために記述するものであり、それはソースコードに埋め込まれずにlocaleファイル等に記述されるべきものであるため。


##基本
* インデントはホワイトスペース2個
* ハードタブは使用しない
* 行の最後に無駄なホワイトスペースは付けない
* 演算子の前後、コロンの前後、カンマの後ろとセミコロンの後ろににホワイトスペースを1個置く
* カンマ、セミコロンの前にはホワイトスペースは置かない

```ruby
sum = 1
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'
```

* 1行の文字数は80文字以下にする
* 80文字を超える時は、以下のルールで改行を入れる
  * メソッドチェーンを途中で改行するときは ``` . ``` （ドット）を改行後の先頭に持ってくる

  ```ruby
    "one string".something_long_long_method(arg1)
      .other_cool_long_method(arg2)
      .another_awsome_long_method(arg3)
  ```

  * メソッドの定義を途中で改行するときは Syntax Error にならないよう適宜 ``` () ``` を用いて改行をする

  ```ruby
    def long_method_name(parameter_1, parameter_2, parameter_3, parameter_4,
      parameter_5, parameter_6, options)
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

* Hash は基本的に1.9の省略記法で記載する

```ruby
# bad
h = {:key => :value}

# good
h = {key: :value}
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
```

* ただし、```case``` の左に何かがある場合には、```when``` の行のインデントを ```case``` の行に対して 1 つ下げる。
```ruby
foo = case
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

* ``` def ``` の後には空行を入れる。

```ruby
def method1
  # some proccesses
end

def some_method2
  # some proccesses
end
```

##文法

* メソッドの定義には ``` () ``` を使わない。ただし以下の場合は適宜 ``` () ``` を使っても良い。
  * メソッドの引数が多い等で80文字に納まらず、改行をする。

```ruby
def method1
  # some proccesses
end

def method2 arg1, arg2
  # some proccesses
end  
```

* メソッドの呼び出しには ``` () ``` を使わない。ただし、以下の場合は適宜 ``` () ``` を使っても良い。
  * 引数に演算子が着いている、またはメソッド前後に演算子が着いている。ハッシュが引数の時も含む。
  * 引数が2個以上である。
  * メソッドの引数が多い等で80文字に納まらず、改行をする。

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

* ``` if ``` の条件に否定演算子 ``` ! ``` を用いてはいけない。その場合は ``` unless ``` を使う。ただし、 ``` && ``` や ``` || ``` と組み合わせる場合は用いても良い。その場合もド・モルガンの法則を利用する等で簡潔な記述を心がけること。

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

# best
user.greeting if user

# OK
if !user.nil? && !user.suspended?
  user.greeting
end

# not bad, but a little too complex
unless user.nil? || user.suspended?
  user.greeting
end

# should be
if user && user.active?
  user.greeting
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

* 変数の初期化に ``` ||= ``` の使用を推奨する。ただし、booleanの変数については、falseの値が上書きされるので注意すること。

```ruby
# set name to Bozhidar, only if it iss nil or false
name ||= 'Bozhidar'

# bad - would set enabled to true even if it was false
enabled ||= true

# good
enabled = true if enabled.nil?
```

* メソッド名と引数の間にはホワイトスペースを入れない

```ruby
# bad
f (3 + 2) + 1

# good
f(3 + 2) + 1
```

* block の引数で使用しないものは ``` _ ``` で受け取る

```ruby
# bad
result = hash.map {|k, v| v + 1}

# good
result = hash.map {|_, v| v + 1}
```

* block の仮引数は変数名に省略した単語を利用して良い。

```ruby
# good
products.each {|product| product.maintain!}

# OK
products.each {|prod| prod.maintain!}
```

* 変数の初期値として 空の Array 、空の Hash を代入する場合には ``` Array.new ```、``` Hash.new ``` と記述する。

```ruby
#bad
@users = []

#good
@users = Array.new

#also good
@months_of_birth_date = User.all.inject([]){|months, user| months << user.birth_date.month}
```

**理由**

オブジェクトの新規作成という意図が明確であるため、「初期化」という意図が伝わりやすい。

##名付け

* メソッド名や変数名には ``` snake_case ``` を使う

* クラス名やモジュール名は ``` CamelCase ``` を使う

* 一般的な定数には ``` SCREAMING_SNAKE_CASE ``` を使う

* boolean を返却する method は ``` Array#empty? ``` のように最後を ``` ? ``` にする

* 破壊的メソッドや危険なメソッドは ``` Array#flatten! ``` のように最後を ``` ! ``` にする。破壊的メソッドを定義する際には ``` Array#flatten ``` のように非破壊的メソッドも用意する。

##クラス

* クラス変数 ``` @@ ``` の利用は本当に必要な時以外は避ける。

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

Parent.print_class_var # => will print "child"
```

* クラスインスタンス変数で実装できないかを検討する。

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

Parent.print_class_var # => will print "parent"
```

* 特異メソッドを定義するときは ``` def self.method ``` や ``` def ClassName.method ``` を使用しない。

```ruby
class TestClass
  # bad
  def TestClass.some_method
    # body omitted
  end

  # bad
  def self.some_other_method
    # body omitted
  end
end
```

* 特異メソッド定義や特異クラスマクロは ``` class << self ``` で記述する。

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

* ``` public ``` メソッドは利用しない

* ``` protected ``` メソッドは ``` private ``` メソッドの前に書く。その時、protected 、 private メソッドの定義は public メソッドと同じ深さのインデントにし、protected 、 private メソッドの上に空行を置き、下には置かない。

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

* private メソッドの呼び出し以外で自分自身を指す時は ``` self ``` を記載する。

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

## 例外

* Exception をフロー制御に利用せずに、避けられる Exception は全て避ける。大域脱出には ``` throw / catch ``` を利用してよい。

**理由**

Exception を発生させると StackTraceを生成するために高い負荷が掛かる。正常処理の中で無用に StackTrace を生成するようなことをしてはいけない。

```ruby
# bad
begin
  n / d
rescue ZeroDivisionError
  puts "Cannot divide by 0!"
end

# good
if d.zero?
  puts "Cannot divide by 0!"
else
  n / d
end
```

**理由**

``` rescue ``` の引数に何も指定しないと ``` RuntimeError ``` を捕捉するので、それより大きい ``` StandardError ``` や ``` Exception ``` を捕捉してはいけない。

特に ``` Exception ``` は例外の基底クラスなので、これを ``` rescue ``` すると、（意図していないかもしれない）全ての例外が捕捉されるので禁止とする。

* ``` Exception ``` クラスを ``` rescue ``` してはいけない。

```ruby
# bad
begin
  # an exception occurs here
rescue
  # exception handling
end

# still bad
begin
  # an exception occurs here
rescue Exception
  # exception handling
end
```

* 文字列の配列を生成する際に、 ``` %w( ) ``` を積極的に利用する。

```ruby
# bad
STATES = ['draft', 'open', 'closed']

# good
STATES = %w(draft open closed)
```

* Hash のキーは文字列を使わず、できる限りシンボルにする。

```ruby
# bad
hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

# good
hash = { one: 1, two: 2, three: 3 }
```

## 文字列

* 文字列への変数を混在する時は連結ではなく、展開を利用する。

```ruby
# bad
email_with_name = user.name + ' <' + user.email + '>'

# good
email_with_name = "#{user.name} <#{user.email}>"
```

* ``` ' ``` は「式展開をしない」、「``` " ```が文字列に含まれる」、「`\`（バックスラッシュ）が文字列に含まれる」等の理由が無い限り使用しない。

```ruby
# bad
name = 'Bozhidar'

# good
name = "Bozhidar"
```

* 再代入する場合、``` String#+ ``` メソッドは使用しない。代わりに ``` String#<< ``` を利用する。

```ruby
# good and also fast
html = ''
html << '<h1>Page title</h1>'

paragraphs.each do |paragraph|
  html << "<p>#{paragraph}</p>"
end
```

* ヒアドキュメントを利用するときには、デリミタを代入文と同じ深さにインデントする。

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
#...後略
```

## 正規表現

* ```  $1 〜 9 ``` は利用しない。マッチした文字列を利用する場合は名前を付ける。

```ruby
# bad
/(regexp)/ =~ string
...
process $1

# good
/(?<meaningful_var>regexp)/ =~ string
...
process meaningful_var
```

* 改行を含む文字列全体の行頭と行末を指定する時には ``` \A ``` と ``` \Z ``` を利用する。

```ruby
string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\Z/] # don't match
```

* 複雑な正規表現パターンを記述する時には ``` x ``` オプションを積極的に利用する。ただし、それを適用すると空白文字が全て無視されることに注意すること。

```ruby
regexp = %r{
  start         # some text
  \s            # white space char
  (group)       # first group
  (?:alt1|alt2) # some alternation
  end
}x
```

## パーセント記法

* ``` %() ``` は文字列自体に ``` " ```を記載する必要がある時にのみ利用する。

```ruby
message = %(注意：'と"は区別されます)
```

* ``` %r() ``` は正規表現のパターン内に ``` / ``` を記載する必要がある時にのみ領する。

```ruby
# bad
%r(\s+)

# still bad
%r(^/(.*)$)
# should be /^\/(.*)$/

# good
%r(^/blog/2011/(.*)$)
```

## 値の比較

* 変数と実数、定数等を比較するときは左辺に実数、右辺に変数とする。

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

** 理由 **

`==` を誤って `=` と記述した際に代入されずに SyntaxError として検知できるため。

## その他

* ``` __END__ ``` は利用しない。
