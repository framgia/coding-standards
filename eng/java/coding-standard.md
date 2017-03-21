# Coding style guide
Document references: 

1. [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
2. [Coding Conventions for the Java Programming Language](http://www.oracle.com/technetwork/java/javase/documentation/codeconvtoc-136057.html)

## 1 Source file basics
### 1.1 File name
The source file name consists of the case-sensitive name of the top-level class it contains (of which there is exactly one), plus the .java extension.

### 1.2 File encoding: UTF-8
Source files are encoded in UTF-8.

### 1.3 Special characters
##### 1.3.1 Whitespace characters
Aside from the line terminator sequence, the ASCII horizontal space character (0x20) is the only whitespace character that appears anywhere in a source file. This implies that:
   1. All other whitespace characters in string and character literals are escaped.
   2. Tab characters are not used for indentation.

##### 1.3.2 Special escape sequences
For any character that has a special escape sequence (\b, \t, \n, \f, \r, \", \' and \\), that sequence is used rather than the corresponding octal (e.g. \012) or Unicode (e.g. \u000a) escape.

##### 1.3.3 Non-ASCII characters
For the remaining non-ASCII characters, either the actual Unicode character (e.g. ∞) or the equivalent Unicode escape (e.g. \u221e) is used. The choice depends only on which makes the code easier to read and understand, although Unicode escapes outside string literals and comments are strongly discouraged.

    Tip: In the Unicode escape case, and occasionally even when actual Unicode characters are used, an explanatory comment can be very helpful.

Examples:

   |Example	                                                         |Discussion                                                            |
   |-----------------------------------------------------------------|----------------------------------------------------------------------|
   |String unitAbbrev = "μs";	                                     |Best: perfectly clear even without a comment.                         |
   |String unitAbbrev = "\u03bcs"; // "μs"	                         |Allowed, but there's no reason to do this.                            |
   |String unitAbbrev = "\u03bcs"; // Greek letter mu, "s"	         |Allowed, but awkward and prone to mistakes.                           |
   |String unitAbbrev = "\u03bcs";	                                 |Poor: the reader has no idea what this is.                            |
   |return '\ufeff' + content; // byte order mark	                 |Good: use escapes for non-printable characters, and comment if necessary.|
       
    Tip: Never make your code less readable simply out of fear that some programs might not handle non-ASCII characters properly. If that should happen, those programs are broken and they must be fixed.