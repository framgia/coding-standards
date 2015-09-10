Basic Coding Standard
=====================

Chương này của bộ standard bao gồm những yếu tố cơ bản được đòi hỏi để có thể đảm bảo
tính tương kết giữa code PHP được chia sẻ.

[PSR-0]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md
[PSR-4]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-4-autoloader.md

1. Khái quát chung
-----------

- Files chỉ được sử dụng tag là `<?php` và `<?=` .

- Files phải encode bằng UTF-8, không dùng BOM (byte-order mark)

- Files có thể định nghĩa symbols (classes, functions, constants, etc.),
  hoặc gây ra side-effects (e.g. tạo ra output, thay đổi .ini settings, etc.),
  thế nhưng không nên làm cả 2.

- Namespaces và tên classes phải tuân theo quy chuẩn "autoloading" của PSR: [[PSR-0], [PSR-4]].

- Tên Class phải được viết dưới dạng `StudlyCaps`.

- Tên constants của Class phải được viết dưới dạng `ALL_UPPER_CASE_WITH_UNDERSCORE`.

- Tên Method phải được viết dưới dạng `camelCase`.


2. Files
--------

### 2.1. PHP Tags

PHP code phải sử dụng tag đầy đủ `<?php ?>` hoặc short-echo `<?= ?>` tags.
Ngoài ra không được sử dụng những tag thay đổi khác. (Không dùng tag `<? ?>`)

### 2.2. Character Encoding

PHP code phải được encode bằng UTF-8 không có BOM.

### 2.3. Side Effects

Files có thể định nghĩa symbols (classes, functions, constants, etc.),
hoặc gây ra side-effects (e.g. tạo ra output, thay đổi .ini settings, etc.),
thế nhưng không nên làm cả 2.

Cụm từ "side effects" mang ý nghĩa là thực hiện những logic mà không liên quan
trực tiếp đến việc định nghĩa classes, functions, constants ... *thường là từ
việc including file*


"Side effects" bao gồm những việc sau (không phải là tất cả): tạo output, sử dụng `require`  `include`, hoặc
kết nối đến external services, thay đổi file ini setting, emit errors hay exceptions,
chỉnh sửa biến global hay static, đọc và viết file ...

Dưới đây là một ví dụ về việc một file chứa cả declarations (định nghĩa) và side effects;

```php
<?php
// side effect: change ini settings
ini_set('error_reporting', E_ALL);

// side effect: loads a file
include "file.php";

// side effect: generates output
echo "<html>\n";

// declaration
function foo()
{
    // function body
}
```

Dưới đây là ví dụ về một file chỉ bao gồm declarations mà không có side effects

```php
<?php
// declaration
function foo()
{
    // function body
}

// conditional declaration is *not* a side effect
if (! function_exists('bar')) {
    function bar()
    {
        // function body
    }
}
```


3. Namespace và tên Class
----------------------------

Namespaces và tên classes phải tuân theo quy chuẩn "autoloading" của PSR: [[PSR-0], [PSR-4]].

Điều này có nghĩa là mỗi class phải được viết vào một file, và phải có ý nhất 1 level trong namespace.

Tên class phải được viết dưới dạng `StudlyCaps`.

Code với phiên bản PHP 5.3 trở lên phải dùng đúng namespaces.

Chẳng hạn:

```php
<?php
// PHP 5.3 and later:
namespace Vendor\Model;

class Foo
{
}
```

Code với phiên bản 5.2.x trở xuống nên dùng pseudo-namespace với `Vendor_` là prefix.

```php
<?php
// PHP 5.2.x and earlier:
class Vendor_Model_Foo
{
}
```

4. Class Constants, Properties, và Methods
-------------------------------------------

Từ class dưới đây được hiểu là cả những class bình thường, hay cả interfaces và traits.

### 4.1. Constants

Constants của class phải được viết hoa toàn bộ và sử dụng gạch dưới ngăn cách giữa các từ.
Ví dụ:

```php
<?php
namespace Vendor\Model;

class Foo
{
    const VERSION = '3.4';
    const DATE_APPROVED = '2014-03-04';
}
```

### 4.2. Properties

Bộ quy tắc này không đưa ra quy định hay gợi ý về việc nên viết properties như thế nào,
theo dạng `$StudlyCaps`, `$camelCase`, hay `$under_score`.
Dù sử dụng quy tắc đặt tên nào đi chăng nữa thì nó cần phải được thực hiện thống nhất trong
một vendor, package, class, method ...

### 4.3. Methods

Tên Method phải được viết dưới dạng `camelCase`.
