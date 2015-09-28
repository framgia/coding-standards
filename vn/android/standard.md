#Cấu trúc của một Dự Án

#### Base Application
* ui
	* fragment
	* activity
	* dialog
	* widget
	* adapter
* service
* data
	* remote
	* local
	* model	 
* util

## 1. Cách đặt tên files

### 1.1 Class files

Tên class phải được viết theo kiểu [UpperCamelCase](https://en.wikipedia.org/wiki/CamelCase)

Đối với những lớp mở rộng trong Android thì tên của class nên kết thúc bằng tên của lớp mở rộng đó

Ví dụ: LoginActivity, MainActivity, UserController, WeatherService, SiginInDialog....

### 1.2 Tên file tài nguyên <Resources>

Được đặt theo định dạnh : lowercase_underscore

#### 1.2.1 Tên file Drawables

Quy ước cho tên cho Drawables:


| Kiểu   | Tiếp đầu ngữ            |		Ví dụ               |
|--------------| ------------------|-----------------------------|
| Action bar   | `ab_`             | `ab_stacked.9.png`          |
| Button       | `btn_`	            | `btn_send_pressed.9.png`    |
| Dialog       | `dialog_`         | `dialog_top.9.png`          | 
| Divider      | `divider_`        | `divider_horizontal.9.png`  |
| Icon         | `ic_`	            | `ic_star.png`               |
| Menu         | `menu_	`           | `menu_submenu_bg.9.png`     |
| Notification | `notification_`	| `notification_bg.9.png`     |
| Tabs         | `tab_`            | `tab_pressed.9.png`         |

Quy ước cho tên cho Icon (Theo [Android iconography guidelines](http://developer.android.com/design/style/iconography.html)):

| Kiểu                      | Tiếp đầu ngữ       | Ví dụ                      |
| --------------------------------| ----------------   | ---------------------------- | 
| Icons                           | `ic_`              | `ic_star.png`                |
| Launcher icons                  | `ic_launcher`      | `ic_launcher_calendar.png`   |
| Menu icons and Action Bar icons | `ic_menu`          | `ic_menu_archive.png`        |
| Status bar icons                | `ic_stat_notify`   | `ic_stat_notify_msg.png`     |
| Tab icons                       | `ic_tab`           | `ic_tab_recent.png`          |
| Dialog icons                    | `ic_dialog`        | `ic_dialog_info.png`         |

Tên cho selector states:

| Trạng thái	       | Tiếp vị ngữ     | Ví dụ                     |
|--------------|-----------------|-----------------------------|
| Normal       | `_normal`       | `btn_order_normal.9.png`    |
| Pressed      | `_pressed`      | `btn_order_pressed.9.png`   |
| Focused      | `_focused`      | `btn_order_focused.9.png`   |
| Disabled     | `_disabled`     | `btn_order_disabled.9.png`  |
| Selected     | `_selected`     | `btn_order_selected.9.png`  |


#### 1.2.2 Tên Layout

Áp dụng cấu trúc Type _object _ purpose. Tên file phải chứa tên thành phần Android, và nó đặt đầu tiên của tên Files. Ví dụ Tên file layout của `LoginActivity` sẽ là `activity_login.xml`

| Thành phần        | Tên lớp             | Tên layout                 |
| ---------------- | ---------------------- | ----------------------------- |
| Activity         | `UserProfileActivity`  | `activity_user_profile.xml`   |
| Fragment         | `SignUpFragment`       | `fragment_sign_up.xml`        |
| Dialog           | `ChangePasswordDialog` | `dialog_change_password.xml`  |
| AdapterView item | ---                    | `item_person.xml`             |
| Partial layout   | ---                    | `partial_stats_bar.xml`       |

#### 1.2.3 Menu files

Vì menu không chứa các thành phần Android nên để đặt tên Menu cần nên đặt tên theo màn hình sử dụng. Ví dụ trong ``MainActivity` thì tên file menu sẽ là `activity_main.xml`

Chú ý rằng tên file không cần bao goome `menu` vì file đã được chứa trong thư mục `menu`

#### 1.2.4 Values files

Tên tập tin nên có thêm __số nhiều__. Ví dụ `strings.xml`, `styles.xml`, `colors.xml`, `dimens.xml`, `attrs.xml`
