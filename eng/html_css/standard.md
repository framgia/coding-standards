# Framgia HTML-CSS Coding Standard

## Indentation
* Same as in PHP, please use 4 spaces for indentation. DO NOT USE HARD Tab.
* Use lowercase for element names, attributes, attributes values (unless text/CDATA), CSS selectors, properties, property values.
* Remove trailing white spaces.

## HTML
* Use ```<br>```, not ```<br />```
* When quoting attributes, please use double quotation marks
```html
<a href="google.com" class="info">Link to google</a>
```
## CSS
* Omit unit specification after “0” values
```css
margin: 0;
padding: 0;
```
* Omit leading “0”s in values.
```css
font-size: .8em;
```
* Separate words in ID and class names by a hyphen.
```css
#video-id {}
.ads-sample {}
```
* Put declarations in alphabetical order. Ignore vendor-specific prefixes for sorting purposes.
```css
background: fuchsia;
border: 1px solid;
-moz-border-radius: 4px;
-webkit-border-radius: 4px;
border-radius: 4px;
color: black;
text-align: center;
text-indent: 2em;
```
* Use a space between the last selector and the declaration block.
Use a space after a property name’s colon.
```css
h3 {
  font-weight: bold;
}
```

## References
* [Google HTML/CSS Style Guide](https://google-styleguide.googlecode.com/svn/trunk/htmlcssguide.xml).
