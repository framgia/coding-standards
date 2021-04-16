# Coding Style Guide

Document built on references and [Kotlin Code Style Guidelines](https://kotlinlang.org/docs/reference/coding-conventions.html) version 1.4.21

# Kotlin Guideline
1. [Source code organization](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#source-code-organization)
2. [Naming rules](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#naming-rules)
3. [Formatting](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#formatting)
4. [Modifiers](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#modifiers)
5. [Trailing commas](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#trailing-commas)
6. [Documentation comments](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#documentation-comments)
7. [Avoiding redundant constructs](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#avoiding-redundant-constructs)
8. [Idiomatic use of language features](https://github.com/framgia/coding-standards/blob/master/en/android/coding_convention_android_kotlin.md#idiomatic-use-of-language-features)

## Source code organization

### Source file names

If a Kotlin file contains a single class (potentially with related top-level declarations), its name should be the same as the name of the class, with the .kt extension appended. If a file contains multiple classes, or only top-level declarations, choose a name describing what the file contains, and name the file accordingly. Use [Upper Camel case](https://en.wikipedia.org/wiki/Camel_case) with an uppercase first letter (also known as Pascal case), for example: **ProcessDeclarations.kt**

The name of the file should describe what the code in the file does. Therefore, you should avoid using meaningless words such as "Util" in file names.
### Source file organization

Placing multiple declarations (classes, top-level functions or properties) in the same Kotlin source file is encouraged as long as these declarations are closely related to each other semantically and the file size remains reasonable (not exceeding a few hundred lines).

In particular, when defining extension functions for a class which are relevant for all clients of this class, put them in the same file where the class itself is defined. When defining extension functions that make sense only for a specific client, put them next to the code of that client. Do not create files just to hold "all extensions of Foo".

### Class layout

Generally, the contents of a class is sorted in the following order:

1. Property declarations and initializer blocks
2. Secondary constructors
3. Method declarations
4. Companion object

Do not sort the method declarations alphabetically or by visibility, and do not separate regular methods from extension methods. Instead, put related stuff together, so that someone reading the class from top to bottom can follow the logic of what's happening. Choose an order (either higher-level stuff first, or vice versa) and stick to it.

Put nested classes next to the code that uses those classes. If the classes are intended to be used externally and aren't referenced inside the class, put them in the end, after the companion object.

### Interface implementation layout

When implementing an interface, keep the implementing members in the same order as members of the interface (if necessary, interspersed with additional private methods used for the implementation)

### Overload layout

Always put overloads next to each other in a class.

## Naming rules

Package and class naming rules in Kotlin are quite simple:

- Names of packages are always lower case and do not use underscores (org.example.project). Using multi-word names is generally discouraged, but if you do need to use multiple words, you can either simply concatenate them together or use camel case (org.example.myProject).

```kotlin
// Okay
package com.example.deepspace
// WRONG!
package com.example.deepSpace
// WRONG!
package com.example.deep_space
```

- Names of classes and objects start with an upper case letter and use camel case:

```kotlin
open class DeclarationProcessor { /*...*/ }

object EmptyDeclarationProcessor : DeclarationProcessor() { /*...*/ }
```

### Function names

Names of functions, properties and local variables start with a lower case letter and use camel case and no underscores:

```kotlin
fun processDeclarations() { /*...*/ }
var declarationCount = 1
```

Exception: factory functions used to create instances of classes can have the same name as the abstract return type:

```kotlin
interface Foo { /*...*/ }

class FooImpl : Foo { /*...*/ }

fun Foo(): Foo { return FooImpl() }
```

### Names for test methods

In tests (and **only** in tests), it's acceptable to use method names with spaces enclosed in backticks. (Note that such method names are currently not supported by the Android runtime.) Underscores in method names are also allowed in test code.

```kotlin
class MyTestCase {
     @Test fun `ensure everything works`() { /*...*/ }
     
     @Test fun ensureEverythingWorks_onAndroid() { /*...*/ }
}
```

### Property names

Names of constants (properties marked with `const`,or top-level or object `val` properties with no custom `get` function that hold deeply immutable data) should use uppercase underscore-separated names ([screaming snake case](https://en.wikipedia.org/wiki/Snake_case)) names:

```kotlin
const val MAX_COUNT = 8
val USER_NAME_FIELD = "UserName"
```

Names of top-level or object properties which hold objects with behavior or mutable data should use camel case names:

```kotlin
val mutableCollection: MutableSet<String> = HashSet()
```

Names of properties holding references to singleton objects can use the same naming style as object declarations:

```kotlin
val PersonComparator: Comparator<Person> = /*...*/
```

For `enum` constants, it's OK to use either uppercase underscore-separated names (([screaming snake case](https://en.wikipedia.org/wiki/Snake_case))) (`enum class Color { RED, GREEN }`) or upper camel case names, depending on the usage.

### Names for backing properties

If a class has two properties which are conceptually the same but one is part of a public API and another is an implementation detail, use an underscore as the prefix for the name of the private property:

```kotlin
class C {
    private val _elementList = mutableListOf<Element>()

    val elementList: List<Element>
         get() = _elementList
}
```

### Choosing good names

* The name of a class is usually a noun or a noun phrase explaining what the class is: `List`, `PersonReader`.

* The name of a method is usually a verb or a verb phrase saying what the method does: `close`, `readPersons`. The name should also suggest if the method is mutating the object or returning a new one. For instance `sort` is sorting a collection in place, while `sorted` is returning a sorted copy of the collection.

* The names should make it clear what the purpose of the entity is, so it's best to avoid using meaningless words (`Manager`, `Wrapper` etc.) in names.

* When using an acronym as part of a declaration name, capitalize it if it consists of two letters (`IOStream`); capitalize only the first letter if it is longer (`XmlFormatter`, `HttpInputStream`).

![image](https://scontent.fhan5-5.fna.fbcdn.net/v/t1.15752-9/132913239_189601412872109_7752107730559220254_n.png?_nc_cat=101&ccb=2&_nc_sid=ae9488&_nc_ohc=AOLi_mhgyBgAX9qgYMq&_nc_ht=scontent.fhan5-5.fna&oh=0539a167760ebf5aaedb109ba5ff3a5b&oe=60104104)

## Formatting

Use four spaces for indentation. Do not use tabs.

For curly braces, put the opening brace in the end of the line where the construct begins, and the closing brace on a separate line aligned horizontally with the opening construct.

```kotlin
if (elements != null) {
    for (element in elements) {
        // ...
    }
}
```

In Kotlin, semicolons are `optional`, and therefore line breaks are significant. The language design assumes Java-style braces, and you may encounter surprising behavior if you try to use a different formatting style.

### Horizontal whitespace

Put spaces around binary operators `(a + b)`. Exception: don't put spaces around the "range to" operator `(0..i)`.
  
Do not put spaces around unary operators `(a++)`
  
Put spaces between control flow keywords (`if`, `when`, `for` and `while`) and the corresponding opening parenthesis.
  
Do not put a space before an opening parenthesis in a primary constructor declaration, method declaration or method call.

```kotlin
// WRONG!
val two = 1+1

// Okay
val two = 1 + 1
```

Never put a space after `(`, `[`, or before `]`, ).

Never put a space around `.` or `?.`: `foo.bar().filter { it > 2 }.joinToString()`, `foo?.bar()`

Put a space after `//`: `// This is a comment`

Do not put spaces around angle brackets used to specify type parameters: `class Map<K, V> { ... }`

Do not put spaces around `::`: `Foo::class`, `String::length`

Do not put a space before `?` used to mark a nullable type: `String?`

As a general rule, avoid horizontal alignment of any kind. Renaming an identifier to a name with a different length should not affect the formatting of either the declaration or any of the usages.

### Class header formatting

* Classes with a few primary constructor parameters can be written in a single line:

```kotlin
class Person(id: Int, name: String)
```

* Classes with longer headers should be formatted so that each primary constructor parameter is in a separate line with indentation. Also, the closing parenthesis should be on a new line. If we use inheritance, then the superclass constructor call or list of implemented interfaces should be located on the same line as the parenthesis:  

```kotlin
class Person(
    id: Int,
    name: String,
    surname: String
) : Human(id, name) { /*...*/ }
```

* For multiple interfaces, the superclass constructor call should be located first and then each interface should be located in a different line:

```kotlin
class Person(
    id: Int,
    name: String,
    surname: String
) : Human(id, name),
    KotlinMaker { /*...*/ }
```

* For classes with a long supertype list, put a line break after the colon and align all supertype names horizontally:

```kotlin
class MyFavouriteVeryLongClassHolder :
    MyLongHolder<MyFavouriteVeryLongClass>(),
    SomeOtherInterface,
    AndAnotherOne {

    fun foo() { /*...*/ }
}
```

To clearly separate the class header and body when the class header is long, either put a blank line following the class header (as in the example above), or put the opening curly brace on a separate line:

```kotlin
class MyFavouriteVeryLongClassHolder :
    MyLongHolder<MyFavouriteVeryLongClass>(),
    SomeOtherInterface,
    AndAnotherOne 
{
    fun foo() { /*...*/ }
}
```

Use regular indent (four spaces) for constructor parameters.

**Rationale**: This ensures that properties declared in the primary constructor have the same indentation as properties declared in the body of a class.

### Function formatting

If the function signature doesn't fit on a single line, use the following syntax:

```kotlin
fun longMethodName(
    argument: ArgumentType = defaultValue,
    argument2: AnotherArgumentType,
): ReturnType {
    // body
}
```

Use regular indent (4 spaces) for function parameters.
```
Rationale: Consistency with constructor parameters
```
Prefer using an expression body for functions with the body consisting of a single expression.
```kotlin
fun foo(): Int {     // bad
    return 1 
}

fun foo() = 1        // good
```

### Expression body formatting

If the function has an expression body whose first line doesn't fit on the same line as the declaration, put the `=` sign on the first line, and indent the expression body by four spaces.

```kotlin
fun f(x: String, y: String, z: String) =
    veryLongFunctionCallWithManyWords(andLongParametersToo(), x, y, z)
```

### Property formatting

* For very simple read-only properties, consider one-line formatting:

```kotlin
val isEmpty: Boolean get() = size == 0
```

* For more complex properties, always put `get` and `set` keywords on separate lines:

```kotlin
val foo: String
    get() { /*...*/ }
```

For properties with an initializer, if the initializer is long, add a line break after the equals sign and indent the initializer by four spaces:

```kotlin
private val defaultCharset: Charset? =
    EncodingRegistry.getInstance().getDefaultCharsetForPropertiesFiles(file)
```

### Formatting control flow statements

If the condition of an `if` or `when` statement is multiline, always use curly braces around the body of the statement. Indent each subsequent line of the condition by four spaces relative to statement begin. Put the closing parentheses of the condition together with the opening curly brace on a separate line:

```kotlin
if (!component.isSyncing &&
    !hasAnyKotlinRuntimeInScope(module)
) {
    return createKotlinNotConfiguredPanel(module)
}
```

**Rationale**: Tidy alignment and clear separation of condition and statement body

Put the `else`, `catch `, `finally ` keywords, as well as the `while` keyword of a do/while loop, on the same line as the preceding curly brace:

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

* In a `when` statement, if a branch is more than a single line, consider separating it from adjacent case blocks with a blank line:

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

* Put short branches on the same line as the condition, without braces.

```kotlin
when (foo) {
    true -> bar() // good
    false -> { baz() } // bad
}
```

### Method call formatting
In long argument lists, put a line break after the opening parenthesis. Indent arguments by 4 spaces. Group multiple closely related arguments on the same line.

```kotlin
drawSquare(
    x = 10, y = 10,
    width = 100, height = 100,
    fill = true
)
```
Put spaces around the `=` sign separating the argument name and value.

### Chained call wrapping

When wrapping chained calls, put the `.` character or the `?.` operator on the next line, with a single indent:

```kotlin
val anchor = owner
    ?.firstChild!!
    .siblings(forward = true)
    .dropWhile { it is PsiComment || it is PsiWhiteSpace }
```

The first call in the chain usually should have a line break before it, but it's OK to omit it if the code makes more sense that way.

### Lambda formatting

In lambda expressions, spaces should be used around the curly braces, as well as around the arrow which separates the parameters from the body. If a call takes a single lambda, it should be passed outside of parentheses whenever possible.

```kotlin
list.filter { it > 10 }
```

If assigning a label for a lambda, do not put a space between the label and the opening curly brace:

```kotlin
fun foo() {
    ints.forEach lit@{
        // ...
    }
}
```

When declaring parameter names in a multiline lambda, put the names on the first line, followed by the arrow and the newline:

```kotlin
appendCommaSeparated(properties) { prop ->
    val propertyValue = prop.get(obj)  // ...
}
```

If the parameter list is too long to fit on a line, put the arrow on a separate line:

```kotlin
foo {
   context: Context,
   environment: Env
   ->
   context.configureEnv(environment)
}
```
### Annotation formatting

Annotations are typically placed on separate lines, before the declaration to which they are attached, and with the same indentation:

```kotlin
@Target(AnnotationTarget.PROPERTY)
annotation class JsonExclude
```

Annotations without arguments may be placed on the same line:

```kotlin
@JsonExclude @JvmField
var x: String
```
A single annotation without arguments may be placed on the same line as the corresponding declaration:

```kotlin
@Test fun foo() { /*...*/ }
```

### File annotations

File annotations are placed after the file comment (if any), before the `package` statement, and are separated from `package` with a blank line (to emphasize the fact that they target the file and not the package).

```kotlin
/** License, copyright and whatever */
@file:JvmName("FooBar")

package foo.bar
```

## Modifiers

If a declaration has multiple modifiers, always put them in the following order:

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

Place all annotations before modifiers:

```kotlin
@Named("Foo")
private val foo: Foo
```

Unless you're working on a library, omit redundant modifiers (e.g. `public`).

## Trailing commas

A trailing comma is a comma symbol after the last item of a series of elements:

```kotlin
class Person(
    val firstName: String,
    val lastName: String,
    val age: Int, // trailing comma
)
```
Using trailing commas has several benefits:

- It makes version-control diffs cleaner – as all the focus is on the changed value.
- It makes it easy to add and reorder elements – there is no need to add or delete the comma if you manipulate elements.
- It simplifies code generation, for example, for object initializers. The last element can also have a comma.

Trailing commas are entirely optional – your code will still work without them. The Kotlin style guide encourages the use of trailing commas at the declaration site and leaves it at your discretion for the call site.

To enable trailing commas in the IntelliJ IDEA formatter, go to **Settings** | **Editor** | **Code Style** | **Kotlin**, open the Other tab and select the Use trailing comma option.

Kotlin supports trailing commas in the following cases:

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

For longer documentation comments, place the opening /** on a separate line and begin each subsequent line with an asterisk:

```kotlin
/**
 * This is a documentation comment
 * on multiple lines.
 */
```

Short comments can be placed on a single line:

```
/** This is a short documentation comment. */
```

Generally, avoid using `@param` and `@return` tags. Instead, incorporate the description of parameters and return values directly into the documentation comment, and add links to parameters wherever they are mentioned. Use `@param` and `@return` only when a lengthy description is required which doesn't fit into the flow of the main text.

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

## Avoiding redundant constructs
In general, if a certain syntactic construction in Kotlin is optional and highlighted by the IDE as redundant, you should omit it in your code. Do not leave unnecessary syntactic elements in code just "for clarity".

### Unit

If a function returns Unit, the return type should be omitted:

```kotlin
fun foo() { // ": Unit" is omitted here

}
```

### Semicolons

Omit semicolons whenever possible.

### String templates

Don't use curly braces when inserting a simple variable into a string template. Use curly braces only for longer expressions.

```kotlin
println("$name has ${children.size} children")
```

## Idiomatic use of language features

### Immutability

Prefer using immutable data to mutable. Always declare local variables and properties as `val` rather than `var` if they are not modified after initialization.

Always use immutable collection interfaces (`Collection`, `List`, `Set`, `Map`) to declare collections which are not mutated. When using factory functions to create collection instances, always use functions that return immutable collection types when possible:

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

Prefer declaring functions with default parameter values to declaring overloaded functions.

```kotlin
// Bad
fun foo() = foo("a")
fun foo(a: String) { /*...*/ }

// Good
fun foo(a: String = "a") { /*...*/ } 
```

### Type aliases

If you have a functional type or a type with type parameters which is used multiple times in a codebase, prefer defining a type alias for it:

```kotlin
typealias MouseClickHandler = (Any, MouseEvent) -> Unit
typealias PersonIndex = Map<String, Person>
```

If you use a private or internal type alias for avoiding name collision, prefer the `import … as …` mentioned in [Packages and Imports](https://kotlinlang.org/docs/reference/packages.html)

### Lambda parameters

In lambdas which are short and not nested, it's recommended to use the `it` convention instead of declaring the parameter explicitly. In nested lambdas with parameters, parameters should be always declared explicitly.

### Returns in a lambda

Avoid using multiple labeled returns in a lambda. Consider restructuring the lambda so that it will have a single exit point. If that's not possible or not clear enough, consider converting the lambda into an anonymous function.

Do not use a labeled return for the last statement in a lambda.

### Named arguments

Use the named argument syntax when a method takes multiple parameters of the same primitive type, or for parameters of `Boolean` type, unless the meaning of all parameters is absolutely clear from context.

```kotlin
drawSquare(x = 10, y = 10, width = 100, height = 100, fill = true)
```

### Using conditional statements

Prefer using the expression form of `try`, `if` and `when`. Examples:

```kotlin
return if (x) foo() else bar()

return when(x) {
    0 -> "zero"
    else -> "nonzero"
}
```

The above is preferable to:

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

### if versus when

Prefer using `if` for binary conditions instead of `when`. Instead of

```kotlin
when (x) {
    null -> // ...
    else -> // ...
}
```

use `if (x == null) ... else ...`

Prefer using `when` if there are three or more options.

### Using nullable Boolean values in conditions

If you need to use a nullable `Boolean` in a conditional statement, use `if (value == true)` or `if (value == false)` checks.

### Using loops

Prefer using higher-order functions (`filter`, `map` etc.) to loops. Exception: `forEach` (prefer using a regular `for` loop instead, unless the receiver of `forEach` is nullable or `forEach` is used as part of a longer call chain).

When making a choice between a complex expression using multiple higher-order functions and a loop, understand the cost of the operations being performed in each case and keep performance considerations in mind.

### Loops on ranges

Use the `until` function to loop over an open range:

```kotlin
for (i in 0..n - 1) { /*...*/ }  // bad
for (i in 0 until n) { /*...*/ }  // good
```

### Using strings
Prefer using string templates to string concatenation.

Prefer to use multiline strings instead of embedding `\n` escape sequences into regular string literals.

To maintain indentation in multiline strings, use `trimIndent` when the resulting string does not require any internal indentation, or `trimMargin` when internal indentation is required:

```kotlin
assertEquals(
    """
    Foo
    Bar
    """.trimIndent(), 
    value
)

val a = """if(a > 1) {
          |    return a
          |}""".trimMargin()
```

### Functions vs Properties

In some cases functions with no arguments might be interchangeable with read-only properties. Although the semantics are similar, there are some stylistic conventions on when to prefer one to another.

Prefer a property over a function when the underlying algorithm:

- does not throw
- is cheap to calculate (or cached on the first run)
- returns the same result over invocations if the object state hasn't changed

### Using extension functions
Use extension functions liberally. Every time you have a function that works primarily on an object, consider making it an extension function accepting that object as a receiver. To minimize API pollution, restrict the visibility of extension functions as much as it makes sense. As necessary, use local extension functions, member extension functions, or top-level extension functions with private visibility.

> ContextExtensions.kt
***

> ViewExtensions.kt
***

> ...

We don't use extension functions for unrelated functions.

```kotlin
fun String.toUserProperties (): UserProperties {
   return UserProperties (this.toUppercase ())
}
```

One thing to remember is that this functionality will be made available to the entire project (if you don't make it private), which is also a great reason not to create an extension function.

If needed, use `local extension functions`,` member extension functions` or `top-level extension functions` with private visibility.

### Using infix functions

Declare a function as infix only when it works on two objects which play a similar role. Good examples: `and`, `to`, `zip`. Bad example: `add`.

Don't declare a method as infix if it mutates the receiver object.

### Factory functions

If you declare a factory function for a class, avoid giving it the same name as the class itself. Prefer using a distinct name making it clear why the behavior of the factory function is special. Only if there is really no special semantics, you can use the same name as the class.
Example:

```kotlin
class Point(val x: Double, val y: Double) {
    companion object {
        fun fromPolar(angle: Double, radius: Double) = Point(...)
    }
}
```
If you have an object with multiple overloaded constructors that don't call different superclass constructors and can't be reduced to a single constructor with default argument values, prefer to replace the overloaded constructors with factory functions.

### Platform types

A public function/method returning an expression of a platform type must declare its Kotlin type explicitly:
```kotlin
fun apiCall(): String = MyJavaApi.getProperty("name")
```
Any property (package-level or class-level) initialised with an expression of a platform type must declare its Kotlin type explicitly:
```kotlin
class Person {
    val name: String = MyJavaApi.getProperty("name")
}
```
A local value initialized with an expression of a platform type may or may not have a type declaration:
```kotlin
fun main() {
    val name = MyJavaApi.getProperty("name")
    println(name)
}
```
### Using scope functions apply/with/run/also/let

Kotlin provides a variety of functions to execute a block of code in the context of a given object: `let`, `run`, `with`, `apply`, and `also`. For the guidance on choosing the right scope function for your case, refer to

* Execute lambda on non-null objects: **let**
* Introduces an expression as a variable in the local scope: **let**
* Object configuration: **apply**
* Object configuration and result calculation: **run**
* Run statements in which an expression is required: non-extension **run**
* Additional effects: **also**
* Group functions on an object: **with**

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


