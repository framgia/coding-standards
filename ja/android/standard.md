#プロジェクト構成

#### Base Application
* ユーザーインターフェース
	* fragment
	* activity
	* dialog
	* widget
	* adapter
* サビース
* データ
	* remote
	* local
	* model	 
* ユーティリティ

## 1. ファイルに名付ける

### 1.1 クラスファイル

クラス名は[アッパーキャメルケース](https://ja.wikipedia.org/wiki/%E3%82%AD%E3%83%A3%E3%83%A1%E3%83%AB%E3%82%B1%E3%83%BC%E3%82%B9)で書かれないといけない。 

Androidで拡張されるクラスについてクラス名はコンポーネント名で終わるべきである。

例：LoginActivity, MainActivity, UserController, WeatherService, SiginInDialog....

### 1.2 リソースファイル <Resources>

リソースファイル名はローワーケース_アンダースコアで書かれる。

#### 1.2.1 Drawable ファイル

Drawableファイルに名付ける規則:


| タイプ   | 接頭辞            |		例               |
|--------------| ------------------|-----------------------------|
| Action bar   | `ab_`             | `ab_stacked.9.png`          |
| Button       | `btn_`	            | `btn_send_pressed.9.png`    |
| Dialog       | `dialog_`         | `dialog_top.9.png`          | 
| Divider      | `divider_`        | `divider_horizontal.9.png`  |
| Icon         | `ic_`	            | `ic_star.png`               |
| Menu         | `menu_	`           | `menu_submenu_bg.9.png`     |
| Notification | `notification_`	| `notification_bg.9.png`     |
| Tabs         | `tab_`            | `tab_pressed.9.png`         |

Iconファイルに名付ける規則 ([Android iconography guidelines](http://developer.android.com/design/style/iconography.html)により):

| タイプ                      | 接頭辞       | 例                     |
| --------------------------------| ----------------   | ---------------------------- | 
| Icons                           | `ic_`              | `ic_star.png`                |
| Launcher icons                  | `ic_launcher`      | `ic_launcher_calendar.png`   |
| Menu icons and Action Bar icons | `ic_menu`          | `ic_menu_archive.png`        |
| Status bar icons                | `ic_stat_notify`   | `ic_stat_notify_msg.png`     |
| Tab icons                       | `ic_tab`           | `ic_tab_recent.png`          |
| Dialog icons                    | `ic_dialog`        | `ic_dialog_info.png`         |

セレクターステートに名づける：

| ステート	       | 接尾辞     | 例                     |
|--------------|-----------------|-----------------------------|
| Normal       | `_normal`       | `btn_order_normal.9.png`    |
| Pressed      | `_pressed`      | `btn_order_pressed.9.png`   |
| Focused      | `_focused`      | `btn_order_focused.9.png`   |
| Disabled     | `_disabled`     | `btn_order_disabled.9.png`  |
| Selected     | `_selected`     | `btn_order_selected.9.png`  |


#### 1.2.2 レイアウトファイル

object_purposeの構造を使う。レイアウトファイル名はAndroidコンポーネント名に合わせるべきである。例えば、`LoginActivity`のレイアウトファイル名は`activity_login.xml`になる。

| コンポーネント        | クラス名             | レイアウトファイル                 |
| ---------------- | ---------------------- | ----------------------------- |
| Activity         | `UserProfileActivity`  | `activity_user_profile.xml`   |
| Fragment         | `SignUpFragment`       | `fragment_sign_up.xml`        |
| Dialog           | `ChangePasswordDialog` | `dialog_change_password.xml`  |
| AdapterView item | ---                    | `item_person.xml`             |
| Partial layout   | ---                    | `partial_stats_bar.xml`       |

#### 1.2.3 メニューファイル
 
メニューはAndroidコンポーネントを含めないので、画面に従ってメニューファイルに名付けるべきである。例えば、`MainActivity`で、メニューファイル名は`activity_main.xml`になる。

ファイルは`menu`フォルダにおけるので、ファイル名は`menu`を含めないべきである。

#### 1.2.4 Value ファイル

Valueフォルダでリソースファイルは__複数__になるべきである。例えば、`strings.xml`, `styles.xml`, `colors.xml`, `dimens.xml`, `attrs.xml`
