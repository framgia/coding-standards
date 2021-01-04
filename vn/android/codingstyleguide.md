# Coding Style Guide

# Kotlin Guideline
1. [Source code organization](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#source-code-organization)
2. [Naming rules](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#naming-rules)
3. [Formatting](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#formatting)
4. [Modifiers](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#modifiers)
5. [Trailing commas](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#trailing-commas)
6. [Documentation comments](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#documentation-comments)
7. [Idiomatic use of language features](https://github.com/framgia/coding-standards/blob/master/vn/android/codingstyleguide.md#1-java-language-rules#idiomatic-use-of-language-features)

## Source code organization

### Source file names

Nếu file Kotlin chứa một class duy nhất (có thể có các top-level declaration liên quan), tên của nó phải giống với tên của class, với phần mở rộng .kt được thêm vào. Nếu một file chứa nhiều class hoặc chỉ top-level declarations, hãy chọn tên mô tả những gì file chứa và đặt tên file cho phù hợp. Sử dụng chữ hoa [Camel case](https://en.wikipedia.org/wiki/Camel_case) (chữ cái đầu tiên của mỗi từ được viết hoa), ví dụ: **ProcessDeclarations.kt**

Tên của file phải mô tả những gì mã trong file đó làm. Do đó, bạn nên tránh sử dụng các từ vô nghĩa như "Util" trong tên file.

### Source file organization

Việc đặt nhiều khai báo (class, top-level functions hoặc thuộc tính) trong cùng một file Kotlin được khuyến khích triển khai, miễn là các khai báo này có liên quan chặt chẽ với nhau về mặt ngữ nghĩa và kích thước file vẫn hợp lý (không được vượt quá vài trăm dòng).

Đặc biệt, khi xác định các extension function cho một class có liên quan đến tất cả các class khác sử dụng class này, hãy đặt chúng vào cùng một file nơi chính class đó được định nghĩa. Khi xác định các extension function này chỉ có ý nghĩa đối với một class sử dụng cụ thể, bạn hãy đặt chúng bên cạnh code của class sử dụng extension này. 

### Class layout

Nói chung, nội dung của một lớp được sắp xếp theo thứ tự sau:

1. Khai báo thuộc tính (Property declarations) và khối khởi tạo (initializer blocks)
2. Các hàm tạo phụ (Secondary constructors)
3. Khai báo các method
4. Companion object

Không sắp xếp các khai báo method theo thứ tự bảng chữ cái hoặc theo khả năng hiển thị và không tách các phương thức thông thường ra khỏi các phương thức mở rộng. Thay vào đó, hãy tập hợp những thứ liên quan lại với nhau, để ai đó đọc class từ trên xuống dưới có thể dễ dàng theo dõi logic những gì đang xảy ra.

Đặt các nested class bên cạnh mã sử dụng các class đó. Nếu các class được dự định sử dụng bên ngoài và không được tham chiếu bên trong class, hãy đặt chúng ở cuối cùng, sau đối tượng Companion object.

### Interface implementation layout

Khi triển khai một interface trong class, hãy giữ thứ tự triển khai theo thứ tự giống như các thàn phần trong interface (nếu cần, hãy xen kẽ với các private method bổ sung được sử dụng để triển khai)

### Overload layout

Luôn đặt các method overload cạnh nhau trong một lớp.

## Naming rules

Quy tắc đặt tên package và class trong Kotlin khá đơn giản:

- Tên của các package luôn viết thường và không sử dụng dấu gạch dưới (org.example.project). Việc sử dụng tên nhiều từ thường không được khuyến khích, nhưng nếu bạn cần sử dụng nhiều từ, bạn có thể chỉ cần ghép chúng lại với nhau hoặc sử dụng kiểu chữ hoa camel (org.example.myProject).

```kotlin
// Okay
package com.example.deepspace
// WRONG!
package com.example.deepSpace
// WRONG!
package com.example.deep_space
```

- Tên của các class và object bắt đầu bằng chữ hoa và sử dụng kiểu chữ camel case:

```kotlin
open class DeclarationProcessor { /*...*/ }

object EmptyDeclarationProcessor : DeclarationProcessor() { /*...*/ }
```

### Function names

Tên của các function, variable và local variable bắt đầu bằng chữ thường và sử dụng chữ camel case và không có dấu gạch dưới:

```kotlin
fun processDeclarations() { /*...*/ }
var declarationCount = 1
```

Exception: các function gốc được sử dụng để tạo các instance của các class có thể có cùng tên với kiểu trả về trừu tượng:

```kotlin
interface Foo { /*...*/ }

class FooImpl : Foo { /*...*/ }

fun Foo(): Foo { return FooImpl() }
```

### Names for test methods

Trong các function test (và chỉ duy nhất các function test), có thể chấp nhận sử dụng các tên phương thức có khoảng trắng trong dấu gạch nháy đơn. (Lưu ý rằng các tên function như vậy hiện không được Android runtime hỗ trợ.) Dấu gạch dưới trong tên phương thức cũng được phép sử dụng trong mã test.

```kotlin
class MyTestCase {
     @Test fun `ensure everything works`() { /*...*/ }
     
     @Test fun ensureEverythingWorks_onAndroid() { /*...*/ }
}
```

### Property names

Tên của hằng số (thuộc tính được đánh dấu bằng `const`, hoặc `top-level`, hoặc `val` không có hàm `get` tùy chỉnh lưu giữ dữ liệu immutable) nên sử dụng tên được phân tách bằng chữ hoa và được phân tách bằng dấu gạch dưới ([screaming snake case](https://en.wikipedia.org/wiki/Snake_case)):

```kotlin
const val MAX_COUNT = 8
val USER_NAME_FIELD = "UserName"
```

Tên của top-level hoặc các object variable chứa các object có behavior hoặc dữ liệu có thể thay đổi được phải được dùng tên dưới dạng camel case:

```kotlin
val mutableCollection: MutableSet<String> = HashSet()
```

Tên của các thuộc tính chứa các tham chiếu đến các đối tượng singleton có thể sử dụng cùng một kiểu đặt tên như khai báo đối tượng:

```kotlin
val PersonComparator: Comparator<Person> = /*...*/
```

Đối với hằng số `enum`, bạn có thể sử dụng tên viết hoa phân tách bằng dấu gạch dưới ([screaming snake case](https://en.wikipedia.org/wiki/Snake_case)) (`enum class Color { RED, GREEN }`) hoặc sử dụng camel case, tùy thuộc vào cách sử dụng.

### Names for backing properties

Nếu một class có hai propertie giống nhau về mặt khái niệm nhưng một propertie là một phần của public API và một propertie khác là implement, hãy sử dụng dấu gạch dưới làm tiền tố cho tên của private properties đó:

```kotlin
class C {
    private val _elementList = mutableListOf<Element>()

    val elementList: List<Element>
         get() = _elementList
}
```

### Choosing good names

* Tên của một class thường là một danh từ hoặc một cụm danh từ giải thích cho lớp đó là gì: `List`, `PersonReader`.

* Tên của một method thường là một động từ hoặc một cụm động từ nói lên chức năng của method: `close`, `readPersons`. Tên cũng nên gợi ý nếu method đang thay đổi đối tượng hoặc trả về một đối tượng mới. 

Ví dụ: `sort` là sắp xếp một collection, trong khi `sorted` là trả về một bản sao đã sắp xếp của collection đó.

* Tên phải làm rõ mục đích của nó đang là gì, làm gì, vì vậy tốt nhất bạn nên tránh sử dụng các từ vô nghĩa (`Manager`, `Wrapper`, etc) chứa trong tên.

* Khi sử dụng từ viết tắt làm một phần của tên khai báo, hãy viết hoa nó nếu nó bao gồm hai chữ cái (IOStream); chỉ viết hoa chữ cái đầu tiên nếu nó dài hơn (`XmlFormatter`, `HttpInputStream`).

![image](https://scontent.fhan5-5.fna.fbcdn.net/v/t1.15752-9/132913239_189601412872109_7752107730559220254_n.png?_nc_cat=101&ccb=2&_nc_sid=ae9488&_nc_ohc=AOLi_mhgyBgAX9qgYMq&_nc_ht=scontent.fhan5-5.fna&oh=0539a167760ebf5aaedb109ba5ff3a5b&oe=60104104)

## Formatting

Sử dụng bốn dấu cách (` `) để thụt lề. Không sử dụng tab.

Đối với các dấu ngoặc nhọn, hãy đặt dấu `{` ở cuối dòng nơi bắt đầu một cấu trúc và `}` trên một dòng riêng biệt được căn chỉnh theo chiều ngang với `{`.

```kotlin
if (elements != null) {
    for (element in elements) {
        // ...
    }
}
```

Trong Kotlin, dấu chấm phẩy (semicolons) là `optional` và do đó ngắt dòng là rất quan trọng

### Horizontal whitespace

* Đặt dấu cách xung quanh toán tử nhị phân `( a + b )`. Ngoại lệ: không đặt dấu cách xung quanh toán tử "phạm vi thành" `(0..i)`.

```kotlin
// WRONG!
val two = 1+1

// Okay
val two = 1 + 1
```

* Không đặt dấu cách xung quanh các toán tử một ngôi `(a++)`

* Tách bất kỳ từ dành riêng nào, chẳng hạn như `if`, `for` hoặc `catch` khỏi dấu ngoặc đơn mở `(` theo sau nó trên cùng một dòng đó.

```kotlin
// WRONG!
for(i in 0..1) {
}

// Okay
for (i in 0..1) {
}
```

* Tách bất kỳ từ dành riêng nào, chẳng hạn như else hoặc catch, khỏi dấu ngoặc nhọn đóng (}) đứng trước nó trên cùng một dòng đó.

```kotlin
// WRONG!
}else {
}

// Okay
} else {
}
```
* Trước bất kỳ dấu ngoặc nhọn mở nào `{`

```kotlin
// WRONG!
if (list.isEmpty()){
}

// Okay
if (list.isEmpty()) {
}
```
* Những quy tắc ở trên cũng được áp dụng cho một số toán tử đặc biệt
> Mũi tên trong toán tử lamda

```kotlin
// WRONG!
ints.map { value->value.toString() }

// Okay
ints.map { value -> value.toString() }
```
> Nhưng với một số trường hợp sau
* Toán tử `::` của tham chiếu thành viên.
```kotlin
// WRONG
val toString = Any :: toString
// OKAY
val toString = Any::toString
```
* dấu `.` ngăn cách

```kotlin
// WRONG
it . toString()

// OKAY
it.toString()
```
* Toán tử khoảng cách `..` và `?.`

```kotlin
// WRONG
 for (i in 1 .. 4) print(i)
 
// OKAY
 for (i in 1..4) print(i)

// WRONG
foo ?. bar()

// OKAY
foo?.bar()
```

* Trước dấu hai chấm `:` chỉ khi được sử dụng trong khai báo class để chỉ định base class hoặc các interface hoặc khi được sử dụng trong `where` cho [generic constraints](https://kotlinlang.org/docs/reference/generics.html#generic-constraints).

```kotlin
// WRONG!
class Foo: Runnable

// Okay
class Foo : Runnable

// WRONG
fun <T: Comparable> max(a: T, b: T)

// Okay
fun <T : Comparable> max(a: T, b: T)

// WRONG
fun <T> max(a: T, b: T) where T: Comparable<T>

// Okay
fun <T> max(a: T, b: T) where T : Comparable<T>
```

* Sau `,` và `:`

```kotlin
// WRONG!
val oneAndTwo = listOf(1,2)

// Okay
val oneAndTwo = listOf(1, 2)

// WRONG!
class Foo :Runnable

// Okay
class Foo : Runnable
```
* Thêm khoảng trắng vào sau `//`:

```kotlin
// WRONG!
var debugging = false//disabled by default

// Okay
var debugging = false // disabled by default
```

### Class header formatting

* Các class có một vài tham số đầu vào của hàm constructor có thể được viết trong một dòng:

```kotlin
class Person(id: Int, name: String)
```

* Các lớp có tiêu đề dài hơn phải được định dạng để mỗi tham số của constructor nằm trong một dòng riêng biệt có thụt lề. Ngoài ra, dấu ngoặc đóng `)` phải ở một dòng mới. Nếu chúng ta sử dụng kế thừa, thì lệnh gọi constructor của lớp cha hoặc các interface được triển khai phải nằm trên cùng một dòng với dấu ngoặc đơn:

```kotlin
class Person(
    id: Int,
    name: String,
    surname: String
) : Human(id, name) { /*...*/ }
```

* Đối với nhiều interface, lệnh gọi hàm khởi tạo class cha phải được đặt trước và sau đó mỗi interface phải được đặt ở một dòng khác:

```kotlin
class Person(
    id: Int,
    name: String,
    surname: String
) : Human(id, name),
    KotlinMaker { /*...*/ }
```

* Đối với các class có tên và các tham số truyền vào hàm khởi tạo dài, hãy đặt dấu ngắt dòng sau dấu hai chấm và căn chỉnh tất cả các tên của các tham số truyền vào theo chiều ngang:

```kotlin
class MyFavouriteVeryLongClassHolder :
    MyLongHolder<MyFavouriteVeryLongClass>(),
    SomeOtherInterface,
    AndAnotherOne {

    fun foo() { /*...*/ }
}
```

Để phân tách rõ ràng phần tiêu đề và phần thân của lớp khi tiêu đề của class dài, hãy đặt một dòng trống sau tiêu đề lớp (như trong ví dụ trên) hoặc đặt dấu ngoặc nhọn mở trên một dòng riêng biệt:

```kotlin
class MyFavouriteVeryLongClassHolder :
    MyLongHolder<MyFavouriteVeryLongClass>(),
    SomeOtherInterface,
    AndAnotherOne 
{
    fun foo() { /*...*/ }
}
```

Sử dụng thụt lề thông thường (bốn dấu cách ` `) cho các tham số của constructor.

**Cơ sở lý luận**: Điều này đảm bảo rằng các thuộc tính được khai báo trong primary constructor có cùng một thụt đầu dòng với các thuộc tính được khai báo trong phần thân của một class.

### Expression body formatting

* Nếu hàm có phần nội dung biểu thức mà dòng đầu tiên không nằm trên cùng dòng với phần khai báo, hãy đặt dấu = trên dòng đầu tiên và thụt lề phần nội dung biểu thức bốn dấu cách (` `).

```kotlin
fun f(x: String, y: String, z: String) =
    veryLongFunctionCallWithManyWords(andLongParametersToo(), x, y, z)
```

### Property formatting

* Đối với các thuộc tính `read-only` rất đơn giản, hãy xem xét định dạng trên một dòng:

```kotlin
val isEmpty: Boolean get() = size == 0
```

* Đối với các thuộc tính phức tạp hơn, hãy luôn đặt các từ khóa `get` và `set` trên các dòng riêng biệt:

```kotlin
val foo: String
    get() { /*...*/ }
```

Đối với các thuộc tính có phương thức khởi tạo, nếu phương thức khởi tạo dài, hãy thêm dấu ngắt dòng sau dấu bằng `=` và thụt lề phương thức khởi tạo bốn dấu cách:

```kotlin
private val defaultCharset: Charset? =
    EncodingRegistry.getInstance().getDefaultCharsetForPropertiesFiles(file)
```

### Formatting control flow statements

Nếu điều kiện của câu lệnh if hoặc when là nhiều dòng, hãy luôn sử dụng dấu ngoặc nhọn xung quanh phần thân của câu lệnh. Thụt lề mỗi dòng tiếp theo của điều kiện bằng bốn dấu cách. Đặt dấu ngoặc đóng `(` của điều kiện cùng với dấu `}` trên một dòng riêng biệt:

```kotlin
if (!component.isSyncing &&
    !hasAnyKotlinRuntimeInScope(module)
) {
    return createKotlinNotConfiguredPanel(module)
}
```

Cơ sở lý luận: Căn chỉnh gọn gàng và tách biệt rõ ràng giữa điều kiện và nội dung câu lệnh

Đặt các từ khóa `else`, `catch `, `finally `, cũng như từ khóa `while` của vòng lặp `do/while`, trên cùng một dòng với dấu ngoặc nhọn `{` trước:

```kotlin
if (condition) {
    // body
} else {
    // else part
}

try {
    // body
} finally {
    // cleanup
}
```

* Trong câu lệnh when, nếu một nhánh có nhiều hơn một dòng, hãy xem xét tách nó khỏi các khối chữ hoa liền kề bằng một dòng trống:

```kotlin
private fun parsePropertyValue(propName: String, token: Token) {
    when (token) {
        is Token.ValueToken ->
            callback.visitValue(propName, token.value)

        Token.LBRACE -> { // ...
        }
    }
}
```

* Đặt các nhánh ngắn trên cùng một hàng với điều kiện, không có dấu ngoặc nhọn.

```kotlin
when (foo) {
    true -> bar() // good
    false -> { baz() } // bad
}
```

### Chained call wrapping

* Khi chúng ta thực hiện liên tiếp việc gọi các method theo chuỗi, hãy đặt ký tự `.` hoặc dấu `?.` trên các dòng tiếp theo, với một thụt lề duy nhất bằng bốn khoảng trắng (` `):

val anchor = owner
    ?.firstChild!!
    .siblings(forward = true)
    .dropWhile { it is PsiComment || it is PsiWhiteSpace }

* Lời gọi đầu tiên trong chuỗi thường phải có ngắt dòng trước nó, nhưng bạn có thể bỏ qua nó nếu mã của bạn có ý nghĩa hơn theo cách đó.

### Lambda formatting

* Trong biểu thức lambda, khoảng trắng nên được sử dụng xung quanh dấu ngoặc nhọn, cũng như xung quanh `->`, mục đích để phân tách các tham số khỏi phần thân. Nếu một lệnh gọi sử dụng một lambda duy nhất, nó phải được chuyển ra bên ngoài dấu ngoặc đơn bất cứ khi nào có thể.

```kotlin
list.filter { it > 10 }
```

* Nếu gán nhãn cho lambda, không đặt khoảng cách giữa nhãn và dấu ngoặc nhọn mở:

```kotlin
fun foo() {
    ints.forEach lit@{
        // ...
    }
}
```

* Khi khai báo tên tham số trong lambda nhiều dòng, hãy đặt tên trên dòng đầu tiên, tiếp theo là `->` và dòng mới:

appendCommaSeparated(properties) { prop ->
    val propertyValue = prop.get(obj)  // ...
}

* Nếu danh sách tham số quá dài để vừa trên một dòng, hãy đặt `->` trên một dòng riêng biệt:

```kotlin
foo {
   context: Context,
   environment: Env
   ->
   context.configureEnv(environment)
}
```
### Annotation formatting

* Các chú thích thường được đặt trên các dòng riêng biệt, trước phần khai báo mà chúng được đính kèm và có cùng một thụt lề:

```kotlin
@Target(AnnotationTarget.PROPERTY)
annotation class JsonExclude
```

* Các chú thích không có đối số có thể được đặt trên cùng một dòng:

```kotlin
@JsonExclude @JvmField
var x: String
```
* Một chú thích đơn không có đối số có thể được đặt trên cùng một dòng với khai báo tương ứng:

```kotlin
@Test fun foo() { /*...*/ }
```

### File annotations

Chú thích của file phải được đặt sau comment của file (nếu có), trước khai báo package và được phân biệt với package bằng một dòng trống (để nhấn mạnh thực tế là chúng được sử dụng cho file này chứ không phải phạm vi là package).
```kotlin
/** License, copyright and whatever */
@file:JvmName("FooBar")

package foo.bar
```

## Modifiers

1. Nếu một khai báo có nhiều modifiers, hãy luôn đặt chúng theo thứ tự sau:

```kotlin
public / protected / private / internal
expect / actual
final / open / abstract / sealed / const
external
override
lateinit
tailrec
vararg
suspend
inner
enum / annotation / fun // as a modifier in `fun interface`
companion
inline
infix
operator
data
```

2. Đặt tất cả các chú thích trước modifiers:

```kotlin
@Named("Foo")
private val foo: Foo
```

Trừ khi bạn đang làm việc với một thư viện sẵn có, hãy bỏ qua các modifiers không cần thiết (ví dụ: `public`).

## Trailing commas

`Trailing commas` là một ký tự `,` ở element cuối cùng trong một chuỗi các element


```kotlin
class Person(
    val firstName: String,
    val lastName: String,
    val age: Int, // trailing comma
)
```
* Sử dụng `Trailing commas` có một số lợi ích:

1. Nó làm cho việc kiểm soát phiên bản sửa đổi trở nên dễ dàng hơn - vì tất cả sự tập trung đều dồn vào giá trị đã thay đổi.
2. Nó giúp bạn dễ dàng thêm và sắp xếp lại thứ tự các phần tử - không cần thêm hoặc xóa dấu phẩy nếu bạn thao tác các phần tử.
3. Nó đơn giản hóa việc tạo mã code, ví dụ, cho các object initializers. Phần tử cuối cùng cũng có thể có dấu phẩy.
4. Dấu phẩy ở cuối hoàn toàn là tùy chọn - mã của bạn sẽ vẫn hoạt động mà không có chúng. 

Để bật format cho `Trailing commas` trong IntelliJ IDEA, hãy đi tới **Setting** | **Editor** | **Code Style** | **Kotlin**, mở tab `other` và chọn tùy chọn `Use trailing comma`.

Kotlin hỗ trợ dấu phẩy ở cuối trong các trường hợp sau:

**Enumerations**

```kotlin
enum class Direction {
    NORTH,
    SOUTH,
    WEST,
    EAST, // trailing comma
}
```

**Value arguments**

```kotlin
fun shift(x: Int, y: Int) { /*...*/ }

shift(
    25,
    20, // trailing comma
)

val colors = listOf(
    "red",
    "green",
    "blue", // trailing comma
)
```

**Class properties and parameters**

```kotlin
class Customer(
    val name: String,
    val lastName: String, // trailing comma
)

class Customer(
    val name: String,
    lastName: String, // trailing comma
)
```

**Function value parameters**

```kotlin
fun powerOf(
    number: Int, 
    exponent: Int, // trailing comma
) { /*...*/ }

constructor(
    x: Comparable<Number>,
    y: Iterable<Number>, // trailing comma
) {}

fun print(
    vararg quantity: Int,
    description: String, // trailing comma
) {}
```

**Parameters with optional type (including setters)**

```kotlin
val sum: (Int, Int, Int) -> Int = fun(
    x,
    y,
    z, // trailing comma
): Int {
    return x + y + x
}
println(sum(8, 8, 8))
```

**Indexing suffix**

```kotlin
class Surface {
    operator fun get(x: Int, y: Int) = 2 * x + 4 * y - 10
}
fun getZValue(mySurface: Surface, xValue: Int, yValue: Int) =
    mySurface[
        xValue,
        yValue, // trailing comma
    ]
```

**Lambda parameters**

```kotlin
fun main() {
    val x = {
            x: Comparable<Number>,
            y: Iterable<Number>, // trailing comma
        ->
        println("1")
    }

    println(x)
}
```

**when entry**

```kotlin
fun isReferenceApplicable(myReference: KClass<*>) = when (myReference) {
    Comparable::class,
    Iterable::class,
    String::class, // trailing comma
        -> true
    else -> false
}
```

**Collection literals (in annotations)**

```kotlin
annotation class ApplicableFor(val services: Array<String>)

@ApplicableFor([
    "serializer",
    "balancer",
    "database",
    "inMemoryCache", // trailing comma
])
fun run() {}
```

**Type arguments**

```kotlin
fun <T1, T2> foo() {}

fun main() {
    foo<
            Comparable<Number>,
            Iterable<Number>, // trailing comma
            >()
}
```

**Type parameters**

```kotlin
class MyMap<
        MyKey,
        MyValue, // trailing comma
        > {}
```

**Destructuring declarations**

```kotlin
data class Car(val manufacturer: String, val model: String, val year: Int)
val myCar = Car("Tesla", "Y", 2019)

val (
    manufacturer,
    model,
    year, // trailing comma
) = myCar

val cars = listOf<Car>()
fun printMeanValue() {
    var meanValue: Int = 0
    for ((
        _,
        _,
        year, // trailing comma
    ) in cars) {
        meanValue += year
    }
    println(meanValue/cars.size)
}
printMeanValue()
```

## Documentation comments

* Đối với các nhận xét về document dài hơn, hãy đặt phần mở đầu `/**` trên một dòng riêng biệt và bắt đầu mỗi dòng tiếp theo bằng dấu `*`:

```kotlin
/**
 * This is a documentation comment
 * on multiple lines.
 */
```

* Với những comment ngắn thì cần đặt trên một dòng

/** This is a short documentation comment. */

Nói chung, tránh sử dụng thẻ `@param` và `@return`. Thay vào đó, hãy kết hợp mô tả các tham số và trả về giá trị trực tiếp vào nhận xét tài liệu và thêm liên kết đến các tham số ở bất cứ nơi nào chúng được đề cập. Chỉ sử dụng @param và @return khi yêu cầu mô tả dài dòng không phù hợp với flow chung.

```kotlin
// Avoid doing this:

/**
 * Returns the absolute value of the given number.
 * @param number The number to return the absolute value for.
 * @return The absolute value.
 */
fun abs(number: Int) { /*...*/ }

// Do this instead:

/**
 * Returns the absolute value of the given [number].
 */
fun abs(number: Int) { /*...*/ }
```

### Unit

Nếu một function trả về `Unit`, kiểu trả về nên được bỏ qua:

```kotlin
fun foo() { // ": Unit" is omitted here

}
```

### Semicolons

Bỏ qua dấu chấm phẩy bất cứ khi nào có thể.

### String templates

Không sử dụng dấu ngoặc nhọn khi chèn một biến đơn giản vào mẫu chuỗi. Chỉ sử dụng dấu ngoặc nhọn cho các biểu thức dài hơn.

```kotlin
println("$name has ${children.size} children")
```

## Idiomatic use of language features

### Immutability

* Luôn khai báo các biến cục bộ và thuộc tính là `val` thay vì `var` nếu chúng không được sửa đổi sau khi khởi tạo.

* Luôn sử dụng các tập hợp bất biến (`Collection`, `List`, `Set`, `Map`) để khai báo các tập hợp không bị thay đổi. Khi sử dụng các hàm gốc để tạo các collection instances, hãy luôn sử dụng các hàm trả về các collection, bất biến khi có thể:

```kotlin
// Bad: use of mutable collection type for value which will not be mutated
fun validateValue(actualValue: String, allowedValues: HashSet<String>) { ... }

// Good: immutable collection type used instead
fun validateValue(actualValue: String, allowedValues: Set<String>) { ... }

// Bad: arrayListOf() returns ArrayList<T>, which is a mutable collection type
val allowedValues = arrayListOf("a", "b", "c")

// Good: listOf() returns List<T>
val allowedValues = listOf("a", "b", "c")
```

### Default parameter values

Ưu tiên khai báo các hàm với giá trị tham số mặc định hơn khai báo các hàm overloaded

```kotlin
// Bad
fun foo() = foo("a")
fun foo(a: String) { /*...*/ }

// Good
fun foo(a: String = "a") { /*...*/ } 
```

### Type aliases

Nếu bạn có một kiểu chức năng hoặc một kiểu có tham số kiểu được sử dụng nhiều lần trong codebase, hãy xác định kiểu aliases cho nó:

typealias MouseClickHandler = (Any, MouseEvent) -> Unit
typealias PersonIndex = Map<String, Person>

Nếu bạn sử dụng private hoặc internal type alias để tránh xung đột tên, hãy `import … as …` được đề cập trong [Packages and Imports](https://kotlinlang.org/docs/reference/packages.html)

### Lambda parameters

Trong các lambdas ngắn và không được lồng vào nhau, bạn nên sử dụng quy ước `it` thay vì khai báo tham số một cách rõ ràng. Trong lambdas lồng nhau với các tham số, các tham số phải luôn được khai báo rõ ràng.

### Returns in a lambda

Tránh sử dụng nhiều trả về có nhãn trong lambda. Xem xét việc cấu trúc lại lambda để nó có một điểm thoát duy nhất. Nếu điều đó là không thể hoặc không đủ rõ ràng, hãy xem xét chuyển đổi lambda thành một hàm ẩn danh.

Không sử dụng trả về có nhãn cho câu lệnh cuối cùng trong lambda.

### Named arguments

Sử dụng cú pháp đối số được đặt tên, khi một phương thức nhận nhiều tham số của cùng một kiểu nguyên thủy hoặc đối với các tham số thuộc kiểu Boolean, trừ khi ý nghĩa của tất cả các tham số hoàn toàn rõ ràng trong ngữ cảnh.

```kotlin
drawSquare(x = 10, y = 10, width = 100, height = 100, fill = true)
```

### Using conditional statements

Ưu tiên sử dụng dạng biểu thức của `try`, `if` and `when`. Ví dụ:

```kotlin
return if (x) foo() else bar()

return when(x) {
    0 -> "zero"
    else -> "nonzero"
}
```

Trên đây là ưu tiên cho:

```kotlin
if (x)
    return foo()
else
    return bar()
    
when(x) {
    0 -> return "zero"
    else -> return "nonzero"
}
```

### if versus when 

Ưu tiên sử dụng if cho các điều kiện nhị phân thay vì when.

```kotlin
when (x) {
    null -> // ...
    else -> // ...
}
```

sử dụng `if (x == null) ... else ...`

Ưu tiên sử dụng `when` có ba tùy chọn trở lên.

### Using nullable Boolean values in conditions

Nếu bạn cần sử dụng Boolean nullable trong một câu lệnh điều kiện, hãy sử dụng các kiểm tra `if (value == true) hoặc if (value == false)`.

### Using loops

Ưu tiên sử dụng `higher-order functions` (`filter`, `map` etc.) cho các vòng lặp. Ngoại lệ: `forEach` (thích sử dụng vòng lặp for thông thường thay thế, trừ khi người nhận forEach là nullable hoặc forEach được sử dụng như một phần của chuỗi cuộc gọi dài hơn).

Khi thực hiện lựa chọn giữa một biểu thức phức tạp sử dụng nhiều `higher-order functions` và một vòng lặp, hãy hiểu chi phí của các hoạt động được thực hiện trong từng trường hợp và lưu ý các cân nhắc về hiệu suất.

### Loops on ranges

Sử dụng hàm `until` cho việc lặp từ vị trí đầu tiên đến phạm vi cho phép của toán tử lặp:

```kotlin
for (i in 0..n - 1) { /*...*/ }  // bad
for (i in 0 until n) { /*...*/ }  // good
```

### Functions vs Properties

Trong một số trường hợp, các method không có đối số có thể hoán đổi cho nhau bằng các thuộc tính `read-only`. Mặc dù ngữ nghĩa tương tự nhau, nhưng có một số lợi ích sử dụng nhất định.

Ưu tiên sử dụng một thuộc tính hơn một method khi việc tính toán là đơn giản

- không ném ra ngoại lệ
- Chi phí bộ nhớ, ram để tính toán ít tài nguyên hơn (hoặc được lưu vào bộ nhớ cache trong lần chạy đầu tiên)
- Trả về cùng một kết quả so với các lời gọi nếu trạng thái đối tượng không thay đổi

### Using extension functions
Nếu như bạn làm với việc tạo các lớp sử dụng Java, hãy tạo một package extension và tạo các file riêng biệt cho từng loại:

extensions
> ContextExtensions.kt
***

> ViewExtensions.kt
***

> ...

Chúng ta không sử dụng các extension function cho các function không liên quan.

```kotlin
fun String.toUserProperties (): UserProperties {
   return UserProperties (this.toUppercase ())
}
```

Một điều cần nhớ là chức năng này sẽ được cung cấp cho toàn bộ trong project của bạn (nếu bạn không đặt nó là private), đây cũng là một lý do tuyệt vời để không tạo một extension function.

Nếu cần, hãy sử dụng các `local extension functions`, `member extension functions` hoặc `top-level extension functions` với khả năng hiển thị private

### Using scope functions apply/with/run/also/let

Kotlin cung cấp nhiều chức năng khác nhau để thực thi một khối mã trong ngữ cảnh của một đối tượng nhất định: `let`, `run`, `with`, `apply`, và `also`.

* Thực thi lambda trên các non-null object: **let**
* Giới thiệu một biểu thức dưới dạng biến trong phạm vi cục bộ: **let**
* Cấu hình Object: **apply**
* Cấu hình Object và tính toán kết quả: **run**
* Chạy các câu lệnh trong đó một biểu thức được yêu cầu: non-extension **run**
* Additional effects: **also**
* Nhóm các function trên một đối tượng: **with**

# Android Guideline

## 1. Project guidelines

### Project structure

#### Resources files

Resources file names are written in __lowercase_underscore__.

##### Drawable files

Naming conventions for drawables:


| Asset Type   | Prefix            |        Example               |
|--------------| ------------------|-----------------------------|
| Action bar   | `ab_`             | `ab_stacked.9.png`          |
| Button       | `btn_`                | `btn_send_pressed.9.png`    |
| Dialog       | `dialog_`         | `dialog_top.9.png`          |
| Divider      | `divider_`        | `divider_horizontal.9.png`  |
| Icon         | `ic_`                | `ic_star.png`               |
| Menu         | `menu_    `           | `menu_submenu_bg.9.png`     |
| Notification | `notification_`    | `notification_bg.9.png`     |
| Tabs         | `tab_`            | `tab_pressed.9.png`         |

Naming conventions for icons (taken from [Android iconography guidelines](http://developer.android.com/design/style/iconography.html)):

| Asset Type                      | Prefix             | Example                      |
| --------------------------------| ----------------   | ---------------------------- |
| Icons                           | `ic_`              | `ic_star.png`                |
| Launcher icons                  | `ic_launcher`      | `ic_launcher_calendar.png`   |
| Menu icons and Action Bar icons | `ic_menu`          | `ic_menu_archive.png`        |
| Status bar icons                | `ic_stat_notify`   | `ic_stat_notify_msg.png`     |
| Tab icons                       | `ic_tab`           | `ic_tab_recent.png`          |
| Dialog icons                    | `ic_dialog`        | `ic_dialog_info.png`         |

Naming conventions for selector states:

| State           | Suffix          | Example                     |
|--------------|-----------------|-----------------------------|
| Normal       | `_normal`       | `btn_order_normal.9.png`    |
| Pressed      | `_pressed`      | `btn_order_pressed.9.png`   |
| Focused      | `_focused`      | `btn_order_focused.9.png`   |
| Disabled     | `_disabled`     | `btn_order_disabled.9.png`  |
| Selected     | `_selected`     | `btn_order_selected.9.png`  |


#### Layout files

Layout files should match the name of the Android components that they are intended for but moving the top level component name to the beginning. For example, if we are creating a layout for the `SignInActivity`, the name of the layout file should be `activity_sign_in.xml`.

| Component        | Class Name             | Layout Name                   |
| ---------------- | ---------------------- | ----------------------------- |
| Activity         | `UserProfileActivity`  | `activity_user_profile.xml`   |
| Fragment         | `SignUpFragment`       | `fragment_sign_up.xml`        |
| Dialog           | `ChangePasswordDialog` | `dialog_change_password.xml`  |
| AdapterView item | ---                    | `item_person.xml`             |
| Partial layout   | ---                    | `partial_stats_bar.xml`       |

A slightly different case is when we are creating a layout that is going to be inflated by an `Adapter`, e.g to populate a `ListView`. In this case, the name of the layout should start with `item_`.

Note that there are cases where these rules will not be possible to apply. For example, when creating layout files that are intended to be part of other layouts. In this case you should use the prefix `partial_`.

#### Menu files

Similar to layout files, menu files should match the name of the component. For example, if we are defining a menu file that is going to be used in the `UserActivity`, then the name of the file should be `activity_user.xml`

A good practice is to not include the word `menu` as part of the name because these files are already located in the `menu` directory.

#### Values files

Resource files in the values folder should be __plural__, e.g. `strings.xml`, `styles.xml`, `colors.xml`, `dimens.xml`, `attrs.xml`

## 2 Code guidelines

### 2.1 Limit variable scope

_The scope of local variables should be kept to a minimum (Effective Java Item 29). By doing so, you increase the readability and maintainability of your code and reduce the likelihood of error. Each variable should be declared in the innermost block that encloses all uses of the variable._

_Local variables should be declared at the point they are first used. Nearly every local variable declaration should contain an initializer. If you don't yet have enough information to initialize a variable sensibly, you should postpone the declaration until you do._ - ([Android code style guidelines](https://source.android.com/source/code-style.html#limit-variable-scope))

### 2.2 Order import statements

If you are using an IDE such as Android Studio, you don't have to worry about this because your IDE is already obeying these rules. If not, have a look below.

The ordering of import statements is:

1. Android imports
2. Imports from third parties (com, junit, net, org)
3. java and javax
4. Same project imports

To exactly match the IDE settings, the imports should be:

* Alphabetically ordered within each grouping, with capital letters before lower case letters (e.g. Z before a).
* There should be a blank line between each major grouping (android, com, junit, net, org, java, javax).

More info [here](https://source.android.com/source/code-style.html#limit-variable-scope)

### 2.3 Logging guidelines

Use the logging methods provided by the `Log` class to print out error messages or other information that may be useful for developers to identify issues:

* `Log.v(tag: String, msg: String)` (verbose)
* `Log.d(tag: String, msg: String)` (debug)
* `Log.i(tag: String, msg: String)` (information)
* `Log.w(tag: String, msg: String)` (warning)
* `Log.e(tag: String, msg: String`  (error)

### 2.4 String constants, naming, and values

Many elements of the Android SDK such as `SharedPreferences`, `Bundle`, or `Intent` use a key-value pair approach so it's very likely that even for a small app you end up having to write a lot of String constants.

When using one of these components, you __must__ define the keys as a `const val` fields and they should be prefixed as indicated below.

| Element            | Field Name Prefix |
| -----------------  | ----------------- |
| SharedPreferences  | `PREF_`             |
| Bundle             | `BUNDLE_`           |
| Fragment Arguments | `ARGUMENT_`         |
| Intent Extra       | `EXTRA_`            |
| Intent Action      | `ACTION_`           |

Note that the arguments of a Fragment - `Fragment.getArguments()` - are also a Bundle. However, because this is a quite common use of Bundles, we define a different prefix for them.

Example:

```kotlin
// Note the value of the field is the same as the name to avoid duplication issues
const val PREF_EMAIL = "PREF_EMAIL";
const val BUNDLE_AGE = "BUNDLE_AGE";
const val ARGUMENT_USER_ID = "ARGUMENT_USER_ID";

// Intent-related items use full package name as value
const val EXTRA_SURNAME = "com.myapp.extras.EXTRA_SURNAME";
const val ACTION_OPEN_USER = "com.myapp.action.ACTION_OPEN_USER";
```

### 2.5 Arguments in Fragments and Activities

When data is passed into an `Activity` or `Fragment` via an `Intent` or a `Bundle`, the keys for the different values __must__ follow the rules described in the section above.

When an `Activity` or `Fragment` expects arguments, it should provide a `public static` method that facilitates the creation of the relevant `Intent` or `Fragment`.

In the case of Activities the method is usually called `getStartIntent()`:

```kotlin
fun getStartIntent(context: Context?, user: User?): Intent? {
        val intent = Intent(context, ThisActivity::class.java)
        intent.putParcelableExtra(EXTRA_USER, user)
        return intent
    }
```

For Fragments it is named `newInstance()` and handles the creation of the Fragment with the right arguments:

```kotlin
fun newInstance(user: User): UserFragment{
        val args = Bundle()
        
        val fragment = UserFragment()
        fragment.arguments = args
        args.putParcelable(ARGUMENT_USER, user)
        return fragment
    }
```

__Note 1__: These methods should go at the top of the class before `onCreate()`.

__Note 2__: If we provide the methods described above, the keys for extras and arguments should be `private` because there is not need for them to be exposed outside the class.

### 2.6 Line length limit

Code lines should not exceed __100 characters__. If the line is longer than this limit there are usually two options to reduce its length:

* Extract a local variable or method (preferable).
* Apply line-wrapping to divide a single line into multiple ones.

There are two __exceptions__ where it is possible to have lines longer than 100:

* Lines that are not possible to split, e.g. long URLs in comments.
* `package` and `import` statements.

### 2.7 Line-wrapping strategies

There isn't an exact formula that explains how to line-wrap and quite often different solutions are valid. However there are a few rules that can be applied to common cases.

__Break at operators__

When the line is broken at an operator, the break comes __before__ the operator. For example:

```kotlin
val longName: Int = (anotherVeryLongVariable + anEvenLongerOne - thisRidiculousLongOne
                + theFinalOne)
```

__Assignment Operator Exception__

An exception to the `break at operators` rule is the assignment operator `=`, where the line break should happen __after__ the operator.

```kotlin
val longName: Int = 
    anotherVeryLongVariable + anEvenLongerOne - thisRidiculousLongOne + theFinalOne
```

__Method chain case__

When multiple methods are chained in the same line - for example when using Builders - every call to a method should go in its own line, breaking the line before the `.`

```kotlin
Glide.with(this).load("https://...").into(driverLicenseBinding.backSideImg)
```

```kotlin
Glide.with(this)
     .load(it)
     .apply(RequestOptions())
     .placeholder(R.drawable.img_back_license)
     .into(driverLicenseBinding.backSideImg)
```

### 2.8 RxJava chains styling

Rx chains of operators require line-wrapping. Every operator must go in a new line and the line should be broken before the `.`

```kotlin
fun syncLocations(): Observable<Location?>? {
        return mDatabaseHelper.getAllLocations()
                .concatMap(object : Func1<Location?, Observable<out Location?>?>() {
                    fun call(location: Location): Observable<out Location?>? {
                        return mRetrofitService.getLocation(location.id)
                    }
                })
                .retry(object : Func2<Int?, Throwable?, Boolean?>() {
                    fun call(numRetries: Int?, throwable: Throwable?): Boolean? {
                        return throwable is RetrofitError
                    }
                })
    }
```

## 3 XML style rules

### 3.1 Use self closing tags

When an XML element doesn't have any contents, you __must__ use self closing tags.

This is good:

```xml
<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
```

This is __bad__ :

```xml
<!-- Don\'t do this! -->
<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" >
</TextView>
```


### 3.2 Resources naming

Resource IDs and names are written in __lowercase_underscore__.

#### ID naming

IDs should be prefixed with the name of the element in lowercase underscore. For example:


| Element            | Prefix            |
| -----------------  | ----------------- |
| `TextView`           | `text_`             |
| `ImageView`          | `image_`            |
| `Button`             | `button_`           |
| `Menu`               | `menu_`             |

Image view example:

```xml
<ImageView
    android:id="@+id/image_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
```

Menu example:

```xml
<menu>
    <item
        android:id="@+id/menu_done"
        android:title="Done" />
</menu>
```

#### Strings

String names start with a prefix that identifies the section they belong to. For example `registration_email_hint` or `registration_name_hint`. If a string __doesn't belong__ to any section, then you should follow the rules below:


| Prefix             | Description                           |
| -----------------  | --------------------------------------|
| `error_`             | An error message                      |
| `msg_`               | A regular information message         |
| `title_`             | A title, i.e. a dialog title          |
| `action_`            | An action such as "Save" or "Create"  |



#### Styles and Themes

Unlike the rest of resources, style names are written in __UpperCamelCase__.

### 3.3 Attributes ordering

As a general rule you should try to group similar attributes together. A good way of ordering the most common attributes is:

1. View Id
2. Style
3. Layout width and layout height
4. Other layout attributes, sorted alphabetically
5. Remaining attributes, sorted alphabetically

