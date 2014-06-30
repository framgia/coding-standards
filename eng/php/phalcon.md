# Framgia Phalcon Coding Standard

This documentation was created based on [Framgia Hyakkaten Project - Coding Standard(Vietnamese)](https://github.com/framgia/hkt/blob/master/docs/coding_standard.md).

##1. PHP Version

* PHP 5.4 or higher.

##2. Naming rule

* Class's name should be written in UpperCamelCase. Function's name should be written in LowerCamelCase. Private function name should be started with ```_```.

Class example: ```MailSender```, ```UserIdentity```.

Function example: ```addCondition```, ```sendMail```, ```_checkMail```.

* Variable's name should be written in snake_case. Private variable should start with ```_```.

Variable example: ```$user_id```, ```$is_admin```, ```private $_status```.

* Constant variable name should be in capital case, separated by ```_```

Sample: ```A_CONSTANT_VARIABLE```

####3. Indentation

Use 4 spaces for indentation. (DO NOT USE HARD Tab)

##4. String

Use single quote for normal string, double quotes for string which contain php variable.
```php
$str = 'This is a string';
echo "result = {$result}";
```

##5. Control Structures
Control structures contain ```if```, ```for```, ```foreach```, ```while```, ```switch```,...
Below is an example of ```if```.
```php
if ((expr_1) || (expr_2)) {
    // action_1;
} elseif (!(expr_3) && (expr_4)) {
    // action_2;
} else {
    // default_action;
}
```
Some notes:
* Use one space before the first parenthesis, one space between the last parenthesis and the opening bracket.
* Always use curly bracket even if the are not needed.
* Opening curly bracket should be placed in the same line as the control structure.
* Inline assignment should not be used inside of the control structure.
* In case of ```switch``` control structure, ```case``` must have the same indentation level as the control structure.

##6. Function
* Do not use space between function name and the open parenthesis.
* Do not use space between the open parenthesis and the first variable.
* Use space between comma and next varialbe.
* Do not use space between the last variable and the close parenthesis.
* Do not use space between the close parenthesis and semicolon.

```php
$var = foo($bar, $baz, $quux);
```

In case of using multiple parameters when calling function:
* Parameters placed in new line should be indented by 4 spaces in comparison to function call line.
* The close parenthesis should be placed in new line.

```php
$this->someObject->subObject->callThisFunctionWithALongName(
    $this->someOtherFunc(
        $this->someEvenOtherFunc(
            'Help me!',
            [
                'foo'  => 'bar',
                'spam' => 'eggs',
            ],
            23
        ),
        $this->someEvenOtherFunc()
    ),
    $this->wowowowowow(12)
);
```

##7. Class
* Opening curly bracket ```{``` must be placed in new line
```php
class FooBar
{
    //... code goes here
}
```

##8. Function declaration
* Opening curly bracket ```{``` must be placed in new line.
* Try to make your function return something.
```php
function fooBar()
{
    // ... code goes here
    return true;
}
```

##9. Array
* Do not use ```array()```, use ```[]``` instead. 

When dividing array to multiple lines, you can place ```,``` in the final line

```php
$some_array =  [
    'key'  => 'val',
    'foo'  => 'bar',
];
```

##10. PHP Code Tags
* Always you long tags ```<?php  ?>```, instead of short tag ```<? ?>```.
* You can use ```<?= ?>```.
* If your file contains only php code, do not use close tag ```?>```.

##11. Comments
* Use comment style of C (```/*  */```) or C++ (```//```).
* DO NOT use Perl/Shell style (```#```).

##12. Class comment
* Write comment for each variable declared inside class. Comment should be placed righ before declaring variable.

Structure: ```@var ClassName (VariableName) Your comment here```

Example:
```php
/**
 * @var ActiveRecord the currently loaded data model instance.
 */

private $_model;
```
* Write comment for each function declared inside class. Comment should be place right before declaring function.

Structure: 
```php
@param ClassName VariableName
@return ClassName VariableName
```

Example:
```php
/**
* Returns the static model of the specified AR class.
* @param string $className active record class name.
* @return User the static model class
*/
public static function model($className = __CLASS__) 
{
    return parent::model($className);
}
```

# MVC

##13. Model and Database

* Table name should be plural and underscored. For examples: ```users```, ```big_people```, ```news```.
* All tables should have primary key named ```id```.
* Foreign key is named by "singular" name of related table and followed by ```_id```. For examle, if you want to add a field of your table which related to ```id``` of table ```users```, you should name it as ```user_id```.
* Join table should be named by the two related table, seperated by underscored. For example: ```students_subjects```
* Model class corresponding to table should be plural and CameCased. For example: ```Users```, ```BigPeople```, ```News```.

##14. Controller

* Controller which corresponding to a model, should be named same as model's name, followed by Controller. For example: ```UsersController```.
* Action name should be cameBack and followed by Action. For example: ```indexAction```.


##15. View

* File name should be correspond to action name, and written in ```snake_case```
* Use Volt template engine.

If you aren't familiar with Volt, please read the following documents.

Phalcon: Volt Template Engine
http://docs.phalconphp.com/en/latest/reference/volt.html

Jinja2: Template Designer Documentation
http://jinja.pocoo.org/docs/templates/
