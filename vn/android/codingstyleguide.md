# Coding Style Guide
Tài liệu xây dựng trên tài liệu tham khảo và [Android Code Style Guidelines](https://source.android.com/source/code-style.html)

## 1. Java language rules

### 1.1 Đừng bỏ qua trường hợp ngoại lệ

Bạn không bao giờ được làm như sau:

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) { }
}
```

Theo bạn nghĩ nó có thể không bao giờ xảy ra, nhưng một ngày nào đó bạn của bạn sẽ gặp vấn đề này. Bạn phải buộc xử lý nó theo một số cách.

* Ném ngoại lệ lên cho người gọi phương thức

```java
void setServerPort(String value) throws NumberFormatException {
    serverPort = Integer.parseInt(value);
}
```
* Ném lại ngoại lệ với lớp trừu tượng của bạn

```java
void setServerPort(String value) throws ConfigurationException {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        throw new ConfigurationException("Port " + value + " is not valid.");
    }
}
```
* Thay thế một giá trị thích hợp, như giá trị mặc định chẳng hạn

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        serverPort = 80;  // default port for server 
    }
}
```

* Ném ngoại lệ vào một RuntimeException mới. Nhưng bạn chắc chắn rằng bạn muốn làm điều này, vì nó sẽ gây lỗi ứng dụng

```java
void setServerPort(String value) {
    try {
        serverPort = Integer.parseInt(value);
    } catch (NumberFormatException e) {
        throw new RuntimeException("port " + value " is invalid, ", e);
    }
}
```

* Cuối cùng bạn sẽ loại bỏ nó nhưng phải có một lý do chính đáng

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

### 1.2 Không được bắt ngoại lệ chung

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

Xem thêm tại [đây](https://source.android.com/source/code-style.html#dont-catch-generic-exception)

### 1.3 Không sử dụng finalizers

Xem tại đây [Android code style guidelines](https://source.android.com/source/code-style.html#dont-use-finalizers)

### 1.4 Fully qualify imports

Không tốt: `import foo.*;`

Tốt: `import foo.Bar;`

Xem thêm [tại đây](https://source.android.com/source/code-style.html#fully-qualify-imports)

## 2 Java style rules

### 2.1 Định nghĩa và đặt tên

Các trường cần được định nghĩa ở đầu file và tuân theo cú pháp đặt tên như sau.


* Non-public, non-static tên trường bắt đầu bằng chữ __m__.
* static tên trường bắt đầu bằng chữ s __s__.
* Các trường hợp khác bắt đầu bằng chữ viết thường(lower case).
* Public static final đây là một hằng số chúng sẽ sử dụng cú pháp ALL_CAPS_WITH_UNDERSCORES.

Ví dụ:

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

Đặt tên biến, phương thức và lớp. Cần viết tắn như lời nói.

| Good           | Bad            |
| -------------- | -------------- |
| `XmlHttpRequest` | `XMLHTTPRequest` | 
| `getCustomerId`  | `getCustomerID`  | 
| `String url`     | `String URL`     |
| `long id`        | `long ID`        |

### 2.3 Sử dụng khoảng trống(trắng)

Sử dụng 4 khoảng trống cho một khối:

```java
if (x == 1) {
    x++;
}
```

Sử dụng 8 khoảng trống cho việc xuống dòng

```java
Instrument i =
        someLongExpression(that, wouldNotFit, on, one, line);
```

### 2.4 Sử dụng ngoặc kép chuẩn trong Java

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

Trong một số trường hợp ___không sử dụng ngoặc kép___

```java
if (condition) body();
```
Không nên 

```java
if (condition)
    body();  // không tốt!
```

### 2.5 Tiêu chuẩn mặc định chú thích (annotations) trong Java

Theo hướng dẫn trong Android code style guide, Tiêu chuẩn cho chú thích được xác định như sau:

* `@Override`: Phải được sử dụng bất cứ khi nào muốn ghi đè một phương thức từ lớp cha. Ví dụ bạn cần sử dụng phương thức onCreate từ lớp cha Activity thì bạn cần phải ghi đè nó @Override
* `@ SuppressWarnings `: Chú thích này chỉ sử dụng khi mà không thể loại bỏ một cảnh báo

### 2.6 Giới hạn phạm vi của biến

Phạm vi của biến nên giữ một cách tối thiểu. Bởi nếu làm điều đó thì code của bạn dễ đọc, dễ sửa chữa và giảm thiểu lỗi. Mỗi biến cần khái báo trong khối bên trong nhất mà có ứng dụng có thể sử dụng nó.

Biến cục bộ sẽ tồn tại khi lần đầu tiên chúng ta sử dụng. và các biết cục bộ cần phải khai báo. Nếu chưa đủ thông tin để khởi tạo bạn cần chờ đến khi có thể làm. [Xem thêm](https://source.android.com/source/code-style.html#limit-variable-scope)

### 2.7 Hướng dẫn Log

`Log` là một class in ra kết quả lỗi hoặc thông tin nào đó giúp lập trình viên gỡ rối vấn đề:

* `Log.v(String tag, String msg)` (verbose)
* `Log.d(String tag, String msg)` (debug)
* `Log.i(String tag, String msg)` (information)
* `Log.w(String tag, String msg)` (warning)
* `Log.e(String tag, String msg)` (error)

Như một quy định chung, chúng ta khai báo một TAG ở mỗi một file:

```java
public class MyClass {
    private static final String TAG = "MyClass";

    public myMethod() {
        Log.e(TAG, "Thông báo lỗi");
    }
}
```

Và bạn muốn hủy Log khi `Release` và chỉ muốn hiện khi `Debug`:

```java
if (BuildConfig.DEBUG) Log.d(TAG, "Giá trị của bạn X là " + x);
```

### 2.8 Thứ tự member trong class

Nó không phải là giải pháp đúng duy nhất, nhưng nó là gợi ý tốt nên sử dụng:

1. Constants 
2. Fields 
3. Constructors 
4. Override methods and callbacks (public or private)
5. Public methods
6. Private methods
7. Inner classes or interfaces

Ví dụ:

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

Trong android, tốt nhất lên theo thứ tự vòng đời của Activity or Fragment.

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

### 2.9 Thứ tự tham số trong các phương thức

Trong lập trình Android, khá phổ biến khi một phương thức cần có một `Context`. Nếu bạn viết phương thức `Context` phải là tham số đầu tiên.

Và `callback` luôn là tham số cuối cùng.

Ví dụ:

```java

// Context luôn đầu tiên
public User loadUser(Context context, int userId);

// Callbacks luôn cuối cùng
public void loadUserAsync(Context context, int userId, UserCallback callback);

```

### 2.10 String constants, naming and values

Rất nhiều các yêu tố trong Android như SharedPreferences, Bundle, Intent sử dụng cặp key-value
Khi sử dụng các thành phần này bạn cần định nghĩa các keys như là `static final`:

| Element            | Field Name Prefix |
| -----------------  | ----------------- |
| SharedPreferences  | `PREF_`             |
| Bundle             | `BUNDLE_`           | 
| Fragment Arguments | `ARGUMENT_`         |   
| Intent Extra       | `EXTRA_`            |
| Intent Action      | `ACTION_`           |

Ví dụ:

```java

// Giá trị của biến giống như tên để tránh sự trùng lặp
static final String PREF_EMAIL = "PREF_EMAIL";
static final String BUNDLE_AGE = "BUNDLE_AGE";
static final String ARGUMENT_USER_ID = "ARGUMENT_USER_ID";


// Intent, tên của Action Broadcast nên sử dụng đẩy đủ tên gói như là một giá trị
static final String EXTRA_SURNAME = "com.myapp.extras.EXTRA_SURNAME";
static final String ACTION_OPEN_USER = "com.myapp.action.ACTION_OPEN_USER";


```

### 2.11 Đối số trong Activity và Fragment

Khi truyền dữ liệu qua `Activity` hoặc `Framgment` thông qua `Intent` hoặc `Bundle`, các keys và giá trị phải tuân theo __[Mục 2.10](#210-string-constants-naming-and-values)__ và cần khai báo `public  static`.

Trường hợp gửi một user trong activity, gọi `getProfileIntent()`

```java
public static Intent getProfileIntent(Context context, User user) {
    Intent intent = new Intent(context, ProfileActivity.class);
    intent.putParcelableExtra(EXTRA_USER, user);
    return intent;
}
```

Cho trường hợp dùng fragment.

```java
public static UserFragment newInstance(User user) {
    UserFragment fragment = new UserFragment;
    Bundle args = new Bundle();
    args.putParcelable(ARGUMENT_USER, user);
    fragment.setArguments(args)
    return fragment;
}
```

### 2.12 Giới hạn độ dài dòng

Độ dài của một dòng code không vượt quá __100 ký tự__. Nếu quá giới hạn bạn có 2 cách để giảm chiều dại lại:

* Đẩy ra biến địa phương hoặc phương thức (khuyến khích).
* Áp dụng line-wrapping để chia thành phần thành nhiều dòng nhỏ.

Có hai trường hợp mà bạn có thể dài hơn 100 ký tự:

* Dòng không thể phân chia, ví dụ chiều dài của URLs
* `package` và `import` 

#### 2.12.1 Line-wrapping strategies

Không có một công thức và lý thuyết nào giải thích việc xuống dòng, Nhưng có vài quy tắc có thể áp dụng chung như sau.

__Trường hợp phương thức dài__

Khi có nhiều phương thức gọi trên một dòng, ví dụ như khi dụng `Builders` -> mọi phương thức sẽ được gọi trên một dòng và ngăn khi sau dấu `.`

Ví dụ: 

```java

Picasso.with(context).load("https://farm6.staticflickr.com/5595/14899879106_f5028bd19d_k.jpg").into(imageView);


```

Thành

```java

Picasso.with(context)
		.load("https://farm6.staticflickr.com/5595/14899879106_f5028bd19d_k.jpg")
		.into(imageView);


```

__Tham số dài__

Khi các phương thức có nhiều tham số, và các tham số rất dài thì ta có thể ngăn các các dòng sau dấu `,`

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

Các `operator` Rx buộc phải xuống dòng và trên một dòng mới trước `.`

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

Để format phần năm của ngày tháng dưới dạng `yyyy`, sử dụng `yyyy`.

## 3 XML style rules

### 3.1 Sử dụng thẻ tự đóng

Khi một phần tử XML không có nội dung, bạn cần phải tự đóng thẻ

Nên: 

```xml

<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
   
```

Không nên 

```xml

<TextView
    android:id="@+id/text_view_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" >
</TextView>
   
```

### 3.2 Đặt tên resources

Resource IDs và tên cần khai báo theo lowercase_underscore

#### 3.2.1 Đặt tên ID

Các ID nên bắt đầu bằng tên phần tử và chữ thường gạch chân. Ví dụ:

| Element              | Prefix              |
| -----------------    | -----------------   |
| `TextView`           | `text_`             |
| `ImageView`          | `image_`            | 
| `Button`             | `button_`           |   
| `Menu`               | `menu_`             |
| `RelativeLayout`     | `relative_`         |
| `LinearLayout `      | `linear_`           |


Ví dụ ImageView:

```xml

<ImageView
    android:id="@+id/image_profile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
    

```

Trong một số trường hợp bạn sử dụng thư viện `annotation` thì bạn có thể khai báo như là khai báo biến


```xml

<ImageView
    android:id="@+id/imageProfile"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
    

```

Đôi khi trong một trường hợp cố định nào đó ta có thể loại bỏ __Action và Tên Object__

Ví dụ dưới đây về một list item (từ gói thư viện hỗ trợ của Android)

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

Tên chuối bắt đầu bằng một định danh. Ví dụ `registration_email_hint` hoặc `registration_name_hint`. 
Hoặc nếu không thì theo quy luật sau:

| Tiền tố             | Mô tả                           |
| -----------------  | --------------------------------------|
| `error_`             | Cho thông báo lỗi                   |
| `msg_`               | Cho một thông báo or in nhắn         |       
| `title_`             | Cho tiêu đề, vd tiêu đề dialog, activity         | 
| `action_`            | Hành vi như `Lưu`, `Sửa` , `Xóa`  |

#### 3.2.3 Styles and Themes

Khai báo theo kiểu __UpperCamelCase__.

#### 3.2.4 Thứ tự thuộc tính

Như một quy luật chung thì bạn nên nhóm các thuộc tính giống nhau lại.

1. View Id
2. Style
3. Layout width and layout height
4. Other layout attributes, sorted alphabetically
5. Remaining attributes, sorted alphabetically
