# Coding Style Guide
This document is based on other reference documents and [Android Code Style Guidelines](https://source.android.com/source/code-style.html)

## 1. Java language rules

### 1.1 Don't ignore Exception

Remember you must never do like this:

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) { }
}
```
You must handle every Excpetion in your code in some way.

* Throw Expection up to the caller of your method
```java
void setServerPort(String value) throws NumberFormatException {
    serverPort = Integer.parseInt(value);
}
```
* Throw a new exception that's appropriate to your level of abstraction
```java
void setServerPort(String value) throws ConfigurationException {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        throw new ConfigurationException("Port " + value + " is not valid.");
    }
}
```
* Substitute an appropriate value in the catch {} block
```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        serverPort = 80;  // default port for server 
    }
}
```

* Catch the Exception and throw a new RuntimeException. This is quite risky, because It can cause crash error. 

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        throw new RuntimeException("port " + value " is invalid, ", e);
    }
}
```
* Last resort : You can ignore it if you are confident that everything will be good, but you must comment an appropriate reason.

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        // Method is documented to just ignore invalid user input.
        // serverPort will just be unchanged.
    }
}
```

### 1.2 Don't Catch Generic Exception

You should not do like this.

```java
try {
    someComplicatedIOFunction();        // may throw IOException 
    someComplicatedParsingFunction();   // may throw ParsingException 
    someComplicatedSecurityFunction();  // may throw SecurityException 
    // phew, made it all the way 
} catch (Exception e) {                 // I'll just catch all exceptions 
    handleError();                      // with one generic handler!
}
```

For [more](https://source.android.com/source/code-style.html#dont-catch-generic-exception) information.

### 1.3 Don't Use finalizers

Reference to [Android code style guidelines](https://source.android.com/source/code-style.html#dont-use-finalizers)

### 1.4 Fully qualify imports

BAD : `import foo.*;`

GOOD : `import foo.Bar;`

For mor information [click here](https://source.android.com/source/code-style.html#fully-qualify-imports)

## 2 Java style rules

### 2.1 Java Style Rules

Field names need to be defined at first and follow this conventions.

* Non-public, non-static field names start with m.
* Static field names start with s.
* Other fields start with a lower case letter.
* Public static final fields (constants) are ALL_CAPS_WITH_UNDERSCORES.

Example:

```java
public class MyClass {
    public static final int SOME_CONSTANT = 42;
    public int publicField;
    private static MyClass sSingleton;
    int mPackagePrivate;
    private int mPrivate;
    protected int mProtected;
}
```

### 2.2 Treat Acronyms as Words

Naming varibales, methods, classes like this.

| Good           | Bad            |
| -------------- | -------------- |
| `XmlHttpRequest` | `XMLHTTPRequest` | 
| `getCustomerId`  | `getCustomerID`  | 
| `String url`     | `String URL`     |
| `long id`        | `long ID`        |

### 2.3 Use Spaces for Indentation

Use 4 space indents for blocks.

```java
if (x == 1) {
    x++;
}
```

Use 8 space indents for line wraps, including function calls and assignments.
```java
Instrument i =
        someLongExpression(that, wouldNotFit, on, one, line);
```

### 2.4 Use Standard Brace Style in Java

Braces is on the same lines with the code before them. 

```java
class MyClass {
    int func() {
        if (something) {
            // ...
        } else if (somethingElse) {
            // ...
        } else {
            // ...
        }
    }
}
```

If the entire conditional fit on one line, you can put it all one line.

```java
if (condition) body();
```

You should not do this
```java
if (condition)
    body();  // bad!
```

### 2.5 Use Standard Java Annotations

As the instrunction of Android code style guide, standard for Annotations is as following :

* `@Override`: This annotation must be used whenever a method overrides the declaration or implementation from a super-class. For example, if you use onCreate from class Activity, you must also annotate that the method @Overrides the parent class's method.

* `@ SuppressWarnings `: This annotation is used when it is imposible to eliminate a warning.

### 2.6 Limit Variable Scope

The scope of local variables should be kept to a minimum as possible. If you can do it, your code will be very clear, easy to read, fix and maintain and also reduce bugs. Variable should be declared in the inner-most block that application can use it.

Local Variables should be declared when they are used for the first time. If you don't have enough information to initialize a viriable, you should wait until you have enough information. [For more information](https://source.android.com/source/code-style.html#limit-variable-scope)

### 2.7 How to Log

`Log` is a class that print out error messages to help developer to identify problems:

* `Log.v(String tag, String msg)` (verbose)
* `Log.d(String tag, String msg)` (debug)
* `Log.i(String tag, String msg)` (information)
* `Log.w(String tag, String msg)` (warning)
* `Log.e(String tag, String msg)` (error)

As a general rule, we need to use class name as a TAG at each file : 

```java
public class MyClass {
    private static final String TAG = "MyClass";

    public myMethod() {
        Log.e(TAG, "Error message");
    }
}
```

If you want to show Log on `Debug` and disbale Log on `Release`:

```java
if (BuildConfig.DEBUG) Log.d(TAG, "Giá trị của bạn X là " + x);
```

### 2.8 Class member ordering

This is not the only correct solution, but it is recommended to use the following order : 

1. Constants 
2. Fields 
3. Constructors 
4. Override methods and callbacks (public or private)
5. Public methods
6. Private methods
7. Inner classes or interfaces

For example:

```java

public class MainActivity extends Activity {

    private String mTitle;
    private TextView mTextViewTitle;

    public void setTitle(String title) {
        mTitle = title;
    }

    @Override 
    public void onCreate() {
        ...
    }

    private void setUpView() {
        ...
    }

    static class AnInnerClass {

    }

} 


```

In Android, It is better to order following the component's lifecycle:

```java
public class MainActivity extends Activity {

    //Order matches Activity lifecycle  
    @Override 
    public void onCreate() {} 

    @Override 
    public void onResume() {}

    @Override 
    public void onPause() {}

    @Override 
    public void onDestory() {}

}
```

### 2.9 Parameter ordering in methods

In Android, it is common to define methods that take a `Context`. 
If you write a method, `Context` should be the first parameter. 
And `callback` always should be the last parameter.

For example:

```java
// Context always be first
public User loadUser(Context context, int userId);

// Callbacks always be last
public void loadUserAsync(Context context, int userId, UserCallback callback);
```

### 2.10 String constants, naming and values

Many elements of the Android such as SharedPreferences, Bundle or Intent use a key-value pair.

When using one of these components, you must define the keys as a `static final` :

| Element            | Field Name Prefix |
| -----------------  | ----------------- |
| SharedPreferences  | `PREF_`             |
| Bundle             | `BUNDLE_`           | 
| Fragment Arguments | `ARGUMENT_`         |   
| Intent Extra       | `EXTRA_`            |
| Intent Action      | `ACTION_`           |

For example :

```java
// Value of the field is the same as the name to avoid duplication
static final String PREF_EMAIL = "PREF_EMAIL";
static final String BUNDLE_AGE = "BUNDLE_AGE";
static final String ARGUMENT_USER_ID = "ARGUMENT_USER_ID";

// Intent should use full package name as value
static final String EXTRA_SURNAME = "com.myapp.extras.EXTRA_SURNAME";
static final String ACTION_OPEN_USER = "com.myapp.action.ACTION_OPEN_USER";
```

### 2.11 Argument in Activity and Fragment

When passing date into an `Activity` or `Framgment` by `Intent` or `Bundle`, keys must follow the rules __[2.10](#210-string-constants-naming-and-values)__ and need to declare `public  static`.

In case of passing a user into activity, call `getProfileIntent()`

```java
public static Intent getProfileIntent(Context context, User user) {
    Intent intent = new Intent(context, ProfileActivity.class);
    intent.putParcelableExtra(EXTRA_USER, user);
    return intent;
}
```

In case of using fragment.

```java
public static UserFragment newInstance(User user) {
    UserFragment fragment = new UserFragment;
    Bundle args = new Bundle();
    args.putParcelable(ARGUMENT_USER, user);
    fragment.setArguments(args)
    return fragment;
}
```

### 2.12 Line length limit

Code lines should not exceed  __100 characters__. If it exceeds limit, you have 2 ways to recude the length:

* Extract a local variable or method.
* Use line-wrapping to divine into multiple lines.

There are 2 exceptions in which you can exceed more than 100 characters.

* Lines can not split e.g: URLs
* `package` and `import` statement 

#### 2.12.1 Line-wrapping strategies

There isnt't any rules for line-wrap. However, there are some rules that can be used in some common cases. 

__Method chain case__

When there are many methods are chained in the same lines, for example when using `Builders` -> every methods will be called into one line and break the line before the `.`

Example: 

```java

Picasso.with(context).load("https://farm6.staticflickr.com/5595/14899879106_f5028bd19d_k.jpg").into(imageView);


```

Become 

```java

Picasso.with(context)
		.load("https://farm6.staticflickr.com/5595/14899879106_f5028bd19d_k.jpg")
		.into(imageView);


```

__Long parameters case__

When a method has many parameters, and its parameters are very long, we should break line using `,`

```java
loadPicture(context, "https://farm6.staticflickr.com/5595/14899879106_f5028bd19d_k.jpg", mImageViewProfilePicture, clickListener, "Title of the picture");
```

```java
loadPicture(context,
 		"https://farm6.staticflickr.com/5595/14899879106_f5028bd19d_k.jpg",
 		mImageViewProfilePicture, clickListener,
 		"Title of the picture");
```

### 2.13 RxJava chains styling

`operator` Rx must go into new line and have new line before `.`

```java
public Observable<Location> syncLocations() {
    return mDatabaseHelper.getAllLocations()
            .concatMap(new Func1<Location, Observable<? extends Location>>() {
                @Override
                 public Observable<? extends Location> call(Location location) {
                     return mConcurService.getLocation(location.id);
                 }
            })
            .retry(new Func2<Integer, Throwable, Boolean>() {
                 @Override
                 public Boolean call(Integer numRetries, Throwable throwable) {
                     return throwable instanceof RetrofitError;
                 }
            });
}
```

### 2.14 Date format

To format the year part of a date as `yyyy`, use `yyyy`.

## 3 XML style rules

### 3.1 Use self closing tags

WHen an XML element doesn't have any content, you must use self closing tags.

Should: 

```xml

<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
   
```

Should not 

```xml

<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" >
</TextView>
   
```

### 3.2 Naming resources

Resource IDs and names need to be declared in lowercase_underscore

#### 3.2.1 Naming ID

ID should be prefixed with name of element and use underscore. For example :

| Element              | Prefix              |
| -----------------    | -----------------   |
| `TextView`           | `text_`             |
| `ImageView`          | `image_`            | 
| `Button`             | `button_`           |   
| `Menu`               | `menu_`             |
| `RelativeLayout`     | `relative_`         |
| `LinearLayout `      | `linear_`           |


For example ImageView:

```xml

<ImageView
    android:id="@+id/image_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
    

```

In some cases, you use `annotation` library, you can declare as a variable

```xml

<ImageView
    android:id="@+id/imageProfile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
    

```

In some special cases, you can skip  __Action and Object Name__

For example about item list. 

```java

<ImageView xmlns:android="http://schemas.android.com/apk/res/android"
           android:id="@+id/icon"
           android:layout_width="wrap_content"
           android:layout_height="wrap_content"
           android:layout_gravity="center_vertical"
           android:layout_marginLeft="8dip"
           android:layout_marginRight="-8dip"
           android:layout_marginTop="8dip"
           android:layout_marginBottom="8dip"
           android:scaleType="centerInside"
           android:duplicateParentState="true"/>
<TextView
            android:id="@+id/title"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_alignParentTop="true"
            android:layout_alignParentLeft="true"
            android:textAppearance="?attr/textAppearanceListItemSmall"
            android:singleLine="true"
            android:duplicateParentState="true"
            android:ellipsize="marquee"
            android:fadingEdge="horizontal" />

<TextView
            android:id="@+id/shortcut"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_below="@id/title"
            android:layout_alignParentLeft="true"
            android:textAppearance="?android:attr/textAppearanceSmall"
            android:singleLine="true"
            android:duplicateParentState="true" />
```
 

#### 3.2.2 Strings

String names start with a prefix. For example `registration_email_hint` or `registration_name_hint`. 
If a string doesn't belong to any section, follow rules here:

| Prefix             | Description                           |
| -----------------  | --------------------------------------|
| `error_`             | An error message                   |
| `msg_`               | A information message         |       
| `title_`             | A title e.g: dialog, activity title         | 
| `action_`            | An action `Save`, `Edit` , `Delete`  |

#### 3.2.3 Styles and Themes

Declare in __UpperCamelCase__.

#### 3.2.4 Attributes ordering

As a common rules you should group similar attributes together.

1. View Id
2. Style
3. Layout width and layout height
4. Other layout attributes, sorted alphabetically
5. Remaining attributes, sorted alphabetically
