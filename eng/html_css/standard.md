# Sun* HTML-CSS Coding Standard

## Indentation
* Indent by 2 spaces at a time. Don’t use tabs or mix tabs and spaces for indentation..
* Use lowercase for element names, attributes, attributes values (unless text/CDATA), CSS selectors, properties, property values.
* Remove trailing white spaces.

## HTML
* Use ```<br>```, not ```<br />```
* When quoting attributes, please use double quotation marks
```html
<a href="google.com" class="info">Link to google</a>
```
* Multimedia Fallback, Provide alternative contents for multimedia.
```html
<!-- Not recommended -->
<img src="spreadsheet.png">

<!-- Recommended -->
<img src="spreadsheet.png" alt="Spreadsheet screenshot.">
```
* Avoid unnecessary id attributes.
* Prefer class attributes for styling and data attributes for scripting.
* Where id attributes are strictly required, always include a hyphen in the value to ensure it does not match the JavaScript identifier syntax, e.g. use 'user-profile' rather than just 'profile' or 'userProfile'.
```html
<!-- Not recommended: `window.userProfile` will resolve to reference the <div> node -->
<div id="userProfile"></div>

<!-- Recommended: `id` attribute is required and its value includes a hyphen -->
<div aria-describedby="user-profile">
  …
  <div id="user-profile"></div>
  …
</div>
```
## CSS
* Omit unit specification after “0” values
```css
flex: 0px; /* This flex-basis component requires a unit. */
flex: 1 1 0px; /* Not ambiguous without the unit, but needed in IE11. */
margin: 0;
padding: 0;
```
* Leading 0, Always include leading “0”s in values.
* Put 0 in front of values or lengths between -1 and 1.
```css
font-size: 0.8em;
```
* Separate words in ID and class names by a hyphen.
```css
/* Not recommended: does not separate the words “demo” and “image” */
.demoimage {}

/* Not recommended: uses underscore instead of hyphen */
.error_status {}

/* Recommended */
.video-id {}
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
/* Not recommended: missing space */
.video{
  margin-top: 1em;
}

/* Not recommended: unnecessary line break */
.video
{
  margin-top: 1em;
}

/* Recommended */
.video {
  margin-top: 1em;
}
```

## References
* [Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html).
* [B.E.M](https://getbem.com/introduction/)
