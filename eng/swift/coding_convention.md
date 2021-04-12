## Swift coding convention

### Define variables, constants

### Common convention for variables, constants
Can be written in a single line if they have relevance.
```sh
let row: Int, column: Int
```
In case of initialization by writing value is on the right-hand side, do not write data type on the left-hand side.
```sh
// ◯
let text = "Hoge Fuga"

// ☓
let text: String = "Hoge Fuga"

// ◯
let flg = false

// ☓
let flg: Bool = false

// ◯
let frame = CGRectZero

// ☓
let frame: CGRect = CGRectZero
```
Howerver, in case data type is implicit, specification is necessary.
```sh
// ◯ Int / UInt / NSInteger / NSUInteger these data types should be distinguished so specification is necessary
let i: Int = 0

// ◯ Float / CGFloat / Double these data types should be distinguished so specification is necessary
let p: Float = 3.14
```
In case of initialization using New, do not write data type on the left-hand side since it is explicit already.
```sh
// ◯
let image = UIImage(named: "Hoge")

// ☓
let image: UIImage = UIImage(named: "Hoge")

// ◯
let size = CGSize(10.0, 10.0)

// ☓
let size: CGSize = CGRectZero
```
In case of initializing return value of class method using its class data types, do not write data type on the left-hand side since it can be analogized.
```sh
let device = UIDevice.currentDevice()

let app = UIApplication.sharedApplication()
```
In case of casting assignment, data type of variable definition is omitted.
```sh
// ◯
let text = data["text"] as String


// ☓
let text: String = data["text"] as String
```

### Definition of variable
There are many ways to write definition of empty array, associative array along with their initialization so we should refer to Apple standard only.

@see [Collection Types](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html)

```sh
// Array
// ◯
var elements = [Int]()

// ☓
var elements: [Int] = []

// ☓
var elements: [Int] = [Int]()

// ☓
var elements = Array<Int>()


// Associative array
// ◯
var namesOfIntegers = [Int: String]()

// ☓
var namesOfIntegers: [Int: String] = [Int: String]()

// ☓
var namesOfIntegers = Dictionary<Int, String>()
```

Do not declare global variables.
```sh
// ☓
var globalValue: String = "init value"

class Hoge {

}
```

### Definition of constant
In case of variable definition, consider whether it can be defined as a constant or not. Unless it have to be defined as a variable no matter what, define it as a constant.
```sh
let notChangeString = "Hoge"
let notChangeArray = ["Hoge", "Fuga"]
let notChangeDictinary = ["Hoge": "Fuga"]
```
Write a lower-cased “k” prefix for constants of global scope, class scope.
```sh
// Swift
let kAnimationDuration = 0.3
```
```sh
// Objective-C
#define kAnimationDuration 0.3
```
Definition of expression can be written on right-hand side.
```sh
let kGoogleAnalyticsTrackingID = NSBundle.mainBundle().objectForInfoDictionaryKey("GoogleAnalyticsTrackingID") as String
```

### Date format
To format the year part of a date as `yyyy`, use `yyyy`.
```sh
let df = DateFormatter()
df.dateFormat = "yyyy-MM-dd"
```

### String
Swift / String and ObjC / NSString are two different classes. Use Swift / String for string.
```sh
// ◯
var text: String?

// ☓
var text: NSString?
```
If you want to use NSString, convert it into NSString.
```sh
// ◯
("Swift text" as NSString).lowercaseString

// ☓
"Swift text".bridgeToObjectiveC().lowercaseString
```
Use countElements for string count. countElements counts based on number of bytes of individual character. Length of NSString is counted by assuming UTF-16 is 2-byte code.
```sh 
// ◯
countElements("Swift text")

// ☓
("Swift text" as NSString).length
```

Use isEmpty for zero length check of string.
```sh
// ◯
if "Hoge".isEmpty { }

// ☓
if countElements("Swift text") == 0 { }

// ☓
if ("Swift text" as NSString).length == 0 { }
```
Use equivalence operator to compare strings.
```sh
let flg: Bool = "hoge" == "fuga"
```
Use Swift notation for string format. However, 
```sh
// ◯
"\(hoge) is \(fuga)"

// ☓
NSString(format: "%@ is %@", hoge, fuga)

// ◯
let someCGFloat: CGFloat = 0.25
String(format: "%.01f", Float(someCGFloat))

// ☓ Must be converted to Float, or it will become 0.0 which is incorrect
let someCGFloat: CGFloat = 0.25
NSString(format: "%.01f", Float(someCGFloat))
```

### Numeric value
Use Swift’s numerical type for Integer. In iOS SDK > API > ObjC, NSInteger, NSUInteger have been replaced by Int, UInt.
```sh
// Example
// UITableViewDatasource
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```
Use Swift’s decimal type for decimal. However, do not use Swift’s Float for ObjC’s CGFloat. CGFloat may become Float or Double, according to 64-bit or 32-bit CPU.
```sh
// Example
// UITableViewDelegate
func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
```
In case you want to use Float as CGFloat or return value as CGFloat, conversion is necessary.
```sh
let f: Float = 1.0
let c: CGFloat = 1.0
let r = CGFloat(f) + c
```
In Swift, Bool can be nil so it is often used.
In ObjC, Scalar cannot be nil so NSNumber must be used in case nil is required. 
```sh
var flg: Bool?
var index: Int?
```

### nil
Nil in Swift is nil, nil in ObjC is an object pointer which does not exist. That is the difference.
You can assign nil to any data type by unwrapping variable.
```sh
var hoge: AnyObject? = nil
```
You also can assign nil value to associative array.
```sh
var hoge: String?
let hash: [String: String?] = ["hoge": hoge, "fuga": "not nil"]
println(hash)
// -> [hoge: nil, fuga: Optional("not nil")]
```
### Function
In case return value’s data type is void, data type is omitted.
```sh
// ◯
func chnageWorld(text: String) {  }

// ☓
func chnageWorld(text: String) -> () { }

// ☓
func chnageWorld(text: String) -> Void { }
```
Consider the readability of first argument to use external argument name if necessary.
```sh
// ◯
func dateFromString(dateString: String) -> NSDate
dateFromString("2014-03-14") // It is possible to analogize that argument can be string

// ☓
func dateFromString(#dateString: String) -> NSDate
dateFromString(dateString: "2014-03-14") // Redundancy

// ◯
func convertPointAt(#column: Int, #row: Int) -> CGPoint
convertPointAt(column: 42, row: 13) 

// ☓
func convertPointAt(column: Int, #row: Int) -> CGPoint
convertPointAt(42, row: 13) // First argument is implicit
```
Incase first argument’s name can be omitted and, setting the default value, write _.
```sh
func log(_ message: String = "default message") 

log("this is message") // -> this is message
log()                  // -> default message
```
Use default argument.
```sh
// ◯
func stringFromDate(date NSDate = NSDate()) -> String
let text = stringFromDate()

// ☓
let date = NSDate()
func stringFromDate(date NSDate) -> String
let text = stringFromDate(date)
```

### Closure
Do not abbreviate closure argument.
```sh
// ◯
let funcClosure = { (text: String) in
    println(text)
}

// ☓
let funcClosure = { text in
    println(text)
}
```
In case first row is too long, line break before the argument.
```sh
let funcClosure = { 
    (text: String) in
    println(text)
}
```
In case define closure type then initializing it.
```sh
// Initialize closure
let funcClosure = { (text: String) in
    println(text)
}
funcClosure("Hoge")
```
In case define closure type but assign value to it later.
```sh
// Assign value to closure later
var funcClosure: ((text: String) -> ())?
funcClosure = { (text: String) in
    println(text)
}
funcClosure!(text: "Hoge")
```
Use trailing closure if possible.

In case argument data type can be anoligized, use simple argument name.

In case there is only one line of code inside closure and it request return value, ‘return’ statement  is omitted.
```sh
// ◯
["Chris", "Alex", "Ewa", "Barry", "Daniella"].map {
    ($0 as NSString).lowercaseString
}

// ☓
["Chris", "Alex", "Ewa", "Barry", "Daniella"].map({
    ($0 as NSString).lowercaseString
})

// ☓
["Chris", "Alex", "Ewa", "Barry", "Daniella"].map { (value: String) -> String in
    (value as NSString).lowercaseString
}

// ☓
["Chris", "Alex", "Ewa", "Barry", "Daniella"].map {
    return ($0 as NSString).lowercaseString
}
```
In case there is only one line of code inside closure and it does not request return value, write only ‘return’ in the end. This is to prevent the return value returned eventhough it is void.
```sh
let funcClosure = { (text: String) -> String in
    println(text)
    return
}
```

## Control statements

### If statement
Do not use ( ) for the evaluation formula after if.
```sh
// ◯
if a == b { }

// ☓
if (a == b) { }
``` 
### for & for-in statement
Use for-in statement to state loop process.
```sh
// ◯
for index in 0..<3 {
    println("index is \(index)")
}

// ☓
for var index = 0; index < 3; ++index {
    println("index is \(index)")
}


// ◯
for value in array {
    println("index is \(index)")
    println("value is \(value)")    
}

// ☓
for var index = 0; index < array.count; index++ {
    let value = array[index]
    println("value is \(value)")
}
```
Do not cast for-statement to each element of array, cast to the array itself.
```sh
// ◯
for view in self.view.subviews as [UIView] {

}

// ☓
for temp in self.view.subviews {
    let view = temp as UIView
}
```

### Switch statement
Write break when there is no process in case-process.
```sh
switch section {
  case .ProfileSection:
    println("HOGE")
  case .SettingSection:
    break // do nothing
  default:
    break // do nothing
}
```
## Statement convention

### Bracket

Write open bracket in the same line with method or control statements’ bracket.
```sh
// ◯
func changeWorld() {
    //Do something
}

// ☓
func changeWorld()
{
    //Do something
}

// ◯
if user.isHappy {
    //Do something
} else {
    //Do something else
}

// ☓
if user.isHappy
{
    //Do something
}
else {
    //Do something else
}
```

### Semicolon
Do not write semicolon at the end of statement.
```sh
// ◯
println("hoge")

// ☓
println("hoge");
```

### File ending
Ending file by inserting line break.

### Enum
Write enum and case by pascal case.

When case is int and sequence begins from 0, do not write data type of enum and case.
```sh
// ◯
enum CustomResult {
    case Success, Error

}

// ☓
enum CustomResult: Int {
    case Success = 0, Error
}
```
When each case have a value, insert break line for each case.
```sh
// ◯
enum CustomResult: String {
    case Success = "success"
    case Error = "error" 
}
```
Omit the enum name in case data type is assigned to an explicit variable.
```sh
// ◯
button.setTitle("title", forState: .Normal)
var state: UIControlState = .Normal

// ☓
button.setTitle("title", forState: UIControlState.Normal)
var state: UIControlState = UIControlState.Normal
```
When define a global enum, consider if class scope, struct scope can be written or not.
```sh
// ◯
class NetworkManager {
    enum CustomResult: String {
        case Success = "success",
        case Error = "error" 
    }
    var customResult: CustomResult? 
}

// ☓
enum CustomResult: String {
    case Success = "success",
    case Error = "error" 
}

class NetworkManager {
    var customResult: CustomResult? 
}
```

## Class, Struct

### Init
In case inheriting from NSObject, state override for int, call super.init().
```sh
class ArticleData: NSObject {    
    override init() {
        super.init()
    }
}
```
In case not inheriting from NSObject, do as below.
```sh
class ArticleData {    
    init() {

    }
}
```
### Convenience init

TODO:

### Property
Do not use Optional Type or Implicitly Unwrapped Optional Type as property when using init to initialize.

By whether or not there is a change of property, use let or var to define. 

However, if there is a possibility nil will be assigned, use optional to define.  
```sh
// ◯
class ArticleData {
    let createdAt: NSDate

    init() {
        self.createdAt = NSDate()
    }
}

// ☓
class ArticleData {
    let createdAt: NSDate!

    init() {
        self.createdAt = NSDate()
    }
}
```
In case there is only get property, get() is omitted.
```sh
// ◯
class ArticleData {
    var createdAt: NSDate { return NSDate() }
}

// ☓
class ArticleData {
    var createdAt: NSDate { 
        get {
            return NSDate() 
        }
    }
}
```

TODO: didSet

### self
TODO:

### Description
In case class inherited from NSObject, override description property.
```sh
class DataModel: NSObject {
    override var description: String { return "something debug message" }
}
```
In case class not inherited from NSObject, conform to printable protocol.
```sh
class DataModel {
}

extension DataModel: Printable {
    var description: String { return "something debug message" }
}
```

## Access control
TODO

## Delegate
TODO

## Protocol
TODO

## Extension
TODO

## ObjC
### Id type
TODO

## Delegate
TODO

### Define
TODO

## Macro
TODO

## Interface Builder Outlet, Action
Outlet is defined by weak and unwrap.  If you want to automatically generate the property from the street board, add private modifier.

In case remove view from parent view and you want to use this view inherently, state strong instead of weak. In case you want to use this property from external class, do not add private modifier.

```sh
// ◯ 
@IBOutlet private weak var button: UIButton!

// ☓
@IBOutlet weak var button: UIButton!

// ☓
@IBOutlet var button: UIButton!

// ☓ 
@IBOutlet weak var button: UIButton?
```

The type of action’s argument defines action’s original class.
```sh
// ◯ 
@IBAction func buttonTapped(sender: UIButton) {
    println("button tapped!")
}

// ☓ 
@IBAction func buttonTapped(sender: AnyObject) {
    println("button tapped!")
}
```
## Circular referenece problem
TODO

## Macro comment
### #pragma mark
Swift
```sh
// MARK: - View life cycle
```
Objective-C
```sh
#pragma mark -
#pragma mark View life cycle
```
### #warning
Swift
```sh
// WARNING: Clean up this code after testing
```
Objective-C
```sh
#warning Clean up this code after testing
```
### #ifdef
Build setting -> Swift Complier Custom Flags -> -DEBUG (yes, including the –D prefix)
```sh
// Objective-C and Swift
#if DEBUG
// DEBUG CODE
#else
// PRODUCTION CODE
#endif
```
## Export log
Use NSLog for exporting log due to these standpoints.
* NSLog is thread safe, println is not.
* NSlog is exported to device console, println is not.
```sh
// ◯
NSLog("%@ is %@", hoge, fuga)

// ☓
println("\(hoge) is \(fuga)")
```
However, println has following merits against NSLog.

* Fast export. 

* Export appropriate string even when variable is not formatted as string.

## Singleton
Singleton is defined by static constant of struct.
```sh
// ◯
class Singleton {
    class var sharedInstance : Singleton {
        struct Static {
            static let instance : Singleton = Singleton()
        }
        return Static.instance
    }
}
```
Do not write as below.

Define by global constant
```sh
// ☓
let _SingletonSharedInstance = Singleton()

class Singleton  {
    class var sharedInstance : Singleton {
        return _SingletonSharedInstance
    }
}
```
Implement by dispatch_once
```sh
// ☓
class Singleton {
    class var sharedInstance : Singleton {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : Singleton? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Singleton()
        }
        return Static.instance!
    }
}
```

## Reference
* [The Swift Programming Language](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html)

* [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html#//apple_ref/doc/uid/TP40014216)

* [The Official raywenderlich.com Swift Style Guide](https://github.com/raywenderlich/swift-style-%0Aguide)

* [Transitioning from Objective-C to Swift](http://b2cloud.com.au/tutorial/transitioning-from-objective-c-to-swift/)

* [Morizotter Blog](http://blog.morizotter.com/)
