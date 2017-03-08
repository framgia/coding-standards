# Coding Style Guide
This document is based on other reference documents and [Android Code Style Guidelines](https://source.android.com/source/code-style.html)

## 1. Java language rules

### 1.1 Don't ignore Exception

以下のようにしないでください：

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) { }
}
```
どのExceptionでも対応しないといけない。

* メソッドの呼び出し側でThrow Expectionする。
```java
void setServerPort(String value) throws NumberFormatException {
    serverPort = Integer.parseInt(value);
}
```
* 抽象化の程度に合って新しいExceptionをThrowする。
```java
void setServerPort(String value) throws ConfigurationException {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        throw new ConfigurationException("Port " + value + " is not valid.");
    }
}
```
* Catch{} ブロックで適当な値を差し替える。
```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        serverPort = 80;  // default port for server 
    }
}
```

* ExceptionをCatchし、RuntimeExceptionをthrowする。クラッシュを発生する可能性があるので、危険である。 

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        throw new RuntimeException("port " + value " is invalid, ", e);
    }
}
```
* なんでも大丈夫の自信を持ったら無視できるけど、適当な理由をコメントしないといけない。

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

以下のようにしないべきである

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

[詳細](https://source.android.com/source/code-style.html#dont-catch-generic-exception) について

### 1.3 Don't Use finalizers

[Android code style guidelines](https://source.android.com/source/code-style.html#dont-use-finalizers)への参考

### 1.4 Fully qualify imports

良くない : `import foo.*;`

良い : `import foo.Bar;`

詳細については [click here](https://source.android.com/source/code-style.html#fully-qualify-imports)

## 2 Java style rules

### 2.1 Java Style Rules

フィールド名は最初に定義され、下のコンベンションに従うことが必要である。

* Non-public, non-static　フィールドには `m`　から名付ける。
* Static フィールドには `ｓ`　から名付ける。
* 他のフィールドはローワーケース文字から名付ける。
* Public static final フィールド (constants) は ALL_CAPS_WITH_UNDERSCORES.

例：

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

以下のように変数、メソッド、クラスに名付ける

| 良い           | 良くない            |
| -------------- | -------------- |
| `XmlHttpRequest` | `XMLHTTPRequest` | 
| `getCustomerId`  | `getCustomerID`  | 
| `String url`     | `String URL`     |
| `long id`        | `long ID`        |

### 2.3 Use Spaces for Indentation

ブロックは四つのスペースインデントを使う

```java
if (x == 1) {
    x++;
}
```

ラインラップは八つのスペースインデントを使う, 変数への割り当てや関数呼び出しを含める
```java
Instrument i =
        someLongExpression(that, wouldNotFit, on, one, line);
```

### 2.4 Use Standard Brace Style in Java

中括弧は前のコードと同じ行に書かれる
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

条件文は一行で書けたら、一行にすべきである。

```java
if (condition) body();
```

以下のようにしないべきである
```java
if (condition)
    body();  // bad!
```

### 2.5 Use Standard Java Annotations

Android code style guideによりますと、Annotationsの標準は:

* `@Override`: メソッドは親クラスからdeclarationかimplementationをオーバーライドする時、このannotationを使わないといけないである。例えば、ActivityクラスからのonCreateを使用したら、メソッドが親クラスから＠Overrideすることは注釈を付けないと。

* `@ SuppressWarnings `: warningが取り除けない時、このannotationが使われる。

### 2.6 Limit Variable Scope

ローカル変数の範囲はできるだけ最小を保つ。そうすると、コードは明らかに、読みやすく、修正しやすく、維持しやすくなりつつ不具合を減らす。変数はアプリケーションが使えるように最も内側のブロックに宣言すべきである。

ローカル変数は初めての使用される時に宣言すべきである。変数を初期化するための情報が不足なら、十分の情報があるまで待つべきだ。[具体的に](https://source.android.com/source/code-style.html#limit-variable-scope)

### 2.7 How to Log

`Log`は問題を特定できるためにエラーメッセージをprint outするクラスである。

* `Log.v(String tag, String msg)` (verbose)
* `Log.d(String tag, String msg)` (debug)
* `Log.i(String tag, String msg)` (information)
* `Log.w(String tag, String msg)` (warning)
* `Log.e(String tag, String msg)` (error)

一般的なルールによる、ファイルごとにクラス名はTAGとして使われるべきである:

```java
public class MyClass {
    private static final String TAG = "MyClass";

    public myMethod() {
        Log.e(TAG, "Error message");
    }
}
```

`Debug`で表示する、`Release`で表示しない場合は

```java
if (BuildConfig.DEBUG) Log.d(TAG, "Xの値は" + x);
```

### 2.8 Class member ordering

こちらは解決策のみではないけど、以下の順番でおすすめだ:

1. Constants 
2. Fields 
3. Constructors 
4. Override methods and callbacks (public or private)
5. Public methods
6. Private methods
7. Inner classes or interfaces

例：

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

コンポーネントのlifecycleは以下の順に従って並んだほうが良い

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

Androidで、メソッドは常に`Context`がパラメーターとして使う。`Context`は最初、`callback`は最後のパラメーターにすべきである。

例：

```java
// Context always be first
public User loadUser(Context context, int userId);

// Callbacks always be last
public void loadUserAsync(Context context, int userId, UserCallback callback);
```

### 2.10 String constants, naming and values

Androidの色んな素子はkey-value型を使う。例：SharedPreferences、Bundle、Intent。

以上のコンポーネントを仕様したら、keysを`static final`として定義しないといけない：

| 素子            | フィールド名の接頭辞 |
| -----------------  | ----------------- |
| SharedPreferences  | `PREF_`             |
| Bundle             | `BUNDLE_`           | 
| Fragment Arguments | `ARGUMENT_`         |   
| Intent Extra       | `EXTRA_`            |
| Intent Action      | `ACTION_`           |

例：

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

`Intent`か`Bundle`で`Activity`または`Framgment`にデートを渡す時、keysはルールに従わないといけない　__[2.10](#210-string-constants-naming-and-values)__　。そして、　`public  static`で宣言することが必要である。

ユーザーをactivityに渡す場合、`getProfileIntent()`を呼ぶ

```java
public static Intent getProfileIntent(Context context, User user) {
    Intent intent = new Intent(context, ProfileActivity.class);
    intent.putParcelableExtra(EXTRA_USER, user);
    return intent;
}
```

fragmentを使用する場合

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

コード行は__100文字__を超えないべきである。超えた場合、減らす仕方が二つあり：

* ローカル変数かメソッドを使う。
* line-wrappingを使って複数の行に分割する。

100文字以上を使える例外が以下のようになる

* 行が分割できない。例：URLs
* `package`　や　`import`　ステートメント

#### 2.12.1 Line-wrapping strategies 

line-wrapのルールがないけど、共通のケースにおいてルールがある。

__Method chain case__

色んなメソッドが一行でつなぐ時、メソッドごとに一行で呼ばれるつつ`.`の前に改行する。

例： 

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

メソッドは複数のパラメーターがあり、パラメーターも長い時、`,`改行すべきである。

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

Rx`operator`は新しい行にしないといけない、`.`の前に改行する。

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

## 3 XML style rules

### 3.1 Use self closing tags

WHen an XML element doesn't have any content, you must use self closing tags.

XML素子は内容がない場合、`/>`タグを使用すべきである。

良い：

```xml

<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
   
```

良くない：

```xml

<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" >
</TextView>
   
```

### 3.2 Naming resources

Resource IDs や　Resource名はlowercase_underscoreで宣言されることが必要である。

#### 3.2.1 Naming ID

ID should be prefixed with name of element and use underscore. For example :

IDの接頭辞は素子名のアンダースコアにすべきである。例：

| 素子              | 接頭辞              |
| -----------------    | -----------------   |
| `TextView`           | `text_`             |
| `ImageView`          | `image_`            | 
| `Button`             | `button_`           |   
| `Menu`               | `menu_`             |
| `RelativeLayout`     | `relative_`         |
| `LinearLayout `      | `linear_`           |


ImageViewの例：

```xml

<ImageView
    android:id="@+id/image_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
    

```

`annotation` libraryを使用する場合は、変数のように宣言できる。

```xml

<ImageView
    android:id="@+id/imageProfile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
    

```

特別なケースにおいて、__Action and Object Name__をスキップできる。

例えば、リストのアイテムである。

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

String名は接頭辞からである。例：`registration_email_hint` or `registration_name_hint`。 
Stringがどのセクションに属しなかったら、以下のルールに従う：

| 接頭辞             | 説明                           |
| -----------------  | --------------------------------------|
| `error_`             | エーらーメッセージ                   |
| `msg_`               | 情報メッセージ         |       
| `title_`             | タイトル。例： dialog, activity         | 
| `action_`            | アクション `Save`, `Edit` , `Delete`  |

#### 3.2.3 Styles and Themes

__UpperCamelCase__　で宣言

#### 3.2.4 Attributes ordering

As a common rules you should group similar attributes together.

一般的なルールにより、同様のattributesをグループすべきである。

1. View Id
2. Style
3. Layout width and layout height
4. Other layout attributes, sorted alphabetically
5. Remaining attributes, sorted alphabetically