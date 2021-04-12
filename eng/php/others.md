Some other conventions
=====================

The following are some other conventions that are not defined clearly in PSR.

- Use the newest PHP version if possible.
- When declaring array, item list can be split across multiple lines. Then the following rules must be followed:
  - The first item must be put in a new line.
  - There must be only one item per line. Each subsequent line is indented once.
  - There must be a comma at the last line.
  - The mark of ending array declaration (`]` for `[]` or `)` for `array()`) must be put in a new line.

```php
// Bad
$a = [$foo,
    $bar
];

// Bad
$a = [
    $foo, $bar,
    $baz,
];

// Bad
$a = [
    $foo,
    $bar
];

// Bad
$a = [
    $foo,
    $bar,];

// Bad
$a = [$foo, $bar,];

// Good
$a = [
    $foo,
    $bar,
];

$a = [$foo, $bar];
```

- When using PHP >= 5.4, use array short syntax. (`[]` instead of `array()`)
```php
// Good
$a = [];
$b = [
    $key => $value,
    $key2 => $value2,
];

// Bad
$a = array();
$b = array(
    $key => $value,
    $key2 => $value2,
);
```

- Variables MUST be written in `camelCase`. However, Model's properties can be written in `snake_case` so they can be the same with columns name in table in database.
- Use `'` for normal string. Only use `"` when you have PHP variables inside.
```php
$normalString = 'A String';
$specialString = "This is {$normalString}";
```
- There MUST be one space before and after each operator (such as `+`, `-`, `*`, `/`, `.`, `>`, `<`, `==` ...)
- To format the year part of a date as `yyyy`, use `Y`.
