Some other conventions
=====================

The following are some other conventions that are not defined clearly in PSR.

- Use the newest PHP version if possible.
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
