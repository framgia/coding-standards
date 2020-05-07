# Nguyên tắc viết commit message
Format như sau : 
```
Dòng 1: thông tin cơ bản về nội dung thay đổi ( title, tóm tắt, ... )
Dòng 2 (Nếu có): khoảng trắng
Dòng 3 trở đi (Nếu có): Lý do thay đổi, nội dung thay đổi cụ thể, ... 
```

Tiếng Anh, tiếng Nhật đều được, nhưng 1 project thì dùng thống nhất 1 ngôn ngữ thôi. Và không dùng tiếng Việt.

## Dòng 1

Format như sau : 

`[phân loại] tóm tắt`

### Phân loại
Có nhiều loại thao tác đối với code, và tương ứng với nó sẽ là 1 phân loại cụ thể. Vấn đề là có ... hơi nhiều phân loại :D. 

####  Phân loại thông thường
* Fix : sửa bugs
* Hotfix : sửa những bugs khẩn cấp
* Add : thêm file, thêm chức năng
* Modify : sửa, thay đổi tính năng ( không phải bug nhé )
* Change : thay đổi requirement
* Clean : chỉnh sửa, dọn dẹp code
* Disable : vô hiệu hoá ( ví dụ như comment out )
* Remove : xoá file 
* Upgrade : nâng cấp
* Revert : chữa cháy lại những thứ vừa thay đổi

#### Phiên bản đơn giản
Số lượng phân loại trên thực sự là quá nhiều và phức tạp, do đó để đơn giản hoá vấn đề, ta sẽ đưa ra 1 cách phân loại khác nhẹ nhàng hơn.
* Fix : fix bugs
* Add : thêm chức năng, tính năng mới
* Modify : sửa, nâng cấp tính năng ( không phải bugs )
* Remove : xoá ( file )
* Revert : chữa cháy

#### Sử dụng linh hoạt
Phần phân loại này tuỳ theo từng dự án mà phân loại cho phù hợp, không nhất thiết phải sử dụng những định nghĩa trên.

Ví dụ với dự án có frontend, backend, payment, ... thì có thể phân loại dựa theo chức năng.

Tuy nhiên, cần phải định nghĩa chung cách phân loại từ đầu mỗi dự án để tất cả mọi người cùng tuân theo.

### Phần nội dung title
`Động từ + danh từ + #{issue ID}`
Tóm tắt nội dung của những thay đổi trong commit 1 cách ngắn gọn. Theo 1 số quy ước khác thì dòng này sẽ **không quá 80 kí tự**. Ngoài ra cũng nên **hạn chế sử dụng từ chuyên môn**. 

Nếu project sử dụng issue của github thì cuối dòng phải thêm `#{issue ID}` để tận dụng 1 số tiện ích của github. 

### Ví dụ 1 commit message :

[Add]Add project readme #012345

[Modify]Change library AB to version 1.2.0 in setting



# Tiếng Anh trong commit 
## Các từ tiếng Anh hay dùng

**Xác định động từ chính trong 1 commit sẽ dễ hiểu và dễ viết hơn**

### Động từ

Động từ để ở thì hiện tại. 

| ý nghĩa               | từ             |
| --------------------- | -------------- |
| tạo mới               | create         |
| xoá                   | remove, delete |
| cập nhật              | update         |
| cập nhật(version)     | upgrade        |
| thêm                  | add            |
| sử dụng               | use            |
| bao gồm               | include        |
| sửa                   | modify         |
| sửa (bugs)            | fix (a bug)    |
| thay đổi              | change         |
| di chuyển             | move           |
| ghi đè                | replace        |
| mở rộng               | extend         |
| sử dụng/không sử dụng | enable/disable |
| chỉnh lý              | clean          |
| liên kết              | link           |
| gửi                   | send           |
| mở/đóng               | open/close     |

Những từ trừu tượng như implement, improve, support thì không nên dùng. 

### Danh từ
Danh từ ngoài đời thì nhiều chứ trong code thì cũng không nhiều :D. 
Những từ thường hay gặp : 
bug, typo, changelog, config, settings, format, description, argument

### Bổ ngữ, other

Những bổ ngữ hay dùng : 

| ý nghĩa           | từ                   |
| ----------------- | -------------------- |
| vì ..., trong ... | for ...              |
| cùng với...       | with ...             |
| vượt qua...       | over ...             |
| trong...          | in ...               |
| thông qua...      | via ...              |
| từ ... đến ...    | from ... to ...      |
| thay thế cho...   | instead of ...       |
| nếu cần           | if necessary         |
| ...trước/sau      | before .../after ... |

