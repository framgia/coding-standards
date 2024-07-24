# Tiêu chuẩn viết mã Sun* HTML-CSS

## Thụt lề
* Thụt lề 2 khoảng trắng cùng một lúc.
* Sử dụng chữ thường cho tên thành phần, thuộc tính, giá trị thuộc tính (trừ khi văn bản/CDATA), bộ chọn CSS, thuộc tính, giá trị thuộc tính.
* Loại bỏ khoảng trắng ở cuối.

## HTML
* Sử dụng ```<br>```, thay vì ```<br />```
* Khi trích dẫn thuộc tính, vui lòng sử dụng dấu ngoặc kép
```html
<a href="google.com" class="info">Liên kết tới google</a>
```
* Multimedia Fallback, Cung cấp nội dung thay thế cho đa phương tiện.
```html
<!-- Không nên dùng -->
<img src="Lansheet.png">

<!-- Được đề xuất -->
<img src="Spreadsheet.png" alt="Ảnh chụp màn hình bảng tính.">
```
* Tránh các thuộc tính id không cần thiết.
* Ưu tiên các thuộc tính class để tạo kiểu css và thuộc tính data cho dữ liệu.
* Trong trường hợp các thuộc tính id được yêu cầu bắt buộc, hãy luôn bao gồm dấu gạch nối trong giá trị để đảm bảo nó không trùng với cú pháp JavaScript, ví dụ: sử dụng 'user-profile' thay vì 'profile' hoặc 'userProfile'.
```html
<!-- Không nên: `window.userProfile` sẽ thực thi để tham chiếu đến <div> -->
<div id="userProfile"></div>

<!-- Khuyến nghị: thuộc tính `id` là bắt buộc và giá trị của nó bao gồm dấu gạch nối -->
<div aria-describeby="user-profile">
 …
 <div id="user-profile"></div>
 …
</div>
```
## CSS
* Bỏ qua thông số đơn vị sau giá trị “0”
```css
flex: 0px; /* Thành phần flex này yêu cầu một đơn vị. */
flex: 1 1 0px; /* Không mơ hồ nếu không có đơn vị, nhưng cần thiết trong IE11. */
margin: 0;
padding: 0;
```
* Đặt số 0 trước các giá trị trong khoảng từ -1 đến 1.
```css
font-size: 0.8em;
```
* Phân tách các từ trong tên ID và class bằng dấu gạch nối.
```css
/* Không khuyến khích: không tách rời 2 từ “demo” và “image” */
.demoimage {}

/* Không nên dùng: sử dụng dấu gạch dưới thay vì dấu gạch nối */
.error_status {}

/* Khuyến khích */
.video-id {}
.ads-mẫu {}

```
* Sắp xếp thuộc tính css theo thứ tự bảng chữ cái.
* Bỏ qua các tiền tố css dành riêng cho nhà cung cấp trong phần sắp xếp.
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
* Dùng khoảng trắng giữa tên và khối lệnh css.
Sử dụng khoảng trắng sau dấu hai chấm của tên thuộc tính.
```css
/* Không khuyến khích: thiếu khoảng trống */
.video{
  margin-top: 1em;
}

/* Không khuyến khích: ngắt dòng không cần thiết */
.video
{
  margin-top: 1em;
}

/* Khuyến khích */
.video {
  margin-top: 1em;
}
```

## Tài liệu tham chiếu
* [Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html)
* [Quy ước B.E.M](https://getbem.com/introduction/)
