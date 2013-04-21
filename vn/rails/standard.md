#Các quy định về viết code Ruby on Rails (Tập các kiểu chuẩn)

##Thiết lập (Settings)

* Những thiết lập của ứng dụng đặt trong thư mục ``` config/initializers ```. Những đoạn code được đặt trong này sẽ được chạy khi ứng dụng khởi tạo.

* Đối với những file code khởi tạo của các gem như ``` carierwave.rb ``` hoặc ``` active_admin.rb ``` thì đặt tên file giống tên gem.

* Những thiết lập cho từng môi trường development, test, production thì thiết lập trong các file tương ứng trong thư mục ``` config/environments ```

* Thiết lập cho tất cả môi trường thì viết vào ``` config/application.rb ```

* Trong trường hợp tạo môi trường mới như staging thì cố gắng thiết lập gần giống môi trường production

##Routing

* Khi cần phải thêm action vào RESTful resource thì sử dụng ``` member ``` và ``` collection ```

```ruby
# cách viết không tốt
get 'subscriptions/:id/unsubscribe'
resources :subscriptions

# cách viết tốt
resources :subscriptions do
  get 'unsubscribe', on: :member
end

# cách viết không tốt
get 'photos/search'
resources :photos

# cách viết tốt
resources :photos do
  get 'search', on: :collection
end
```

* Sử dụng block để nhóm lại khi có nhiều ``` member/collection ```

```ruby
resources :subscriptions do
  member do
    get 'unsubscribe'
    get 'subscribe'
  end
end

resources :photos do
  collection do
    get 'search'
    get 'trashes'
  end
end
```

* Sử dụng routes lồng nhau (nested routes) để thể hiện mối quan hệ của các model trong ActiveRecord

```ruby
class Post < ActiveRecord::Base
  has_many :comments
end

class Comments < ActiveRecord::Base
  belongs_to :post
end

# routes.rb
resources :posts do
  resources :comments
end
```

* Sử dụng namespace để nhóm các action liên quan

```ruby
namespace :admin do
  # Directs /admin/products/* to Admin::ProductsController
  # (app/controllers/admin/products_controller.rb)
  resources :products
end
```

* Không sử dụng wild controller route trước đây

**Lý do**

Viết theo cách này sẽ làm cho tất cả action của mọi controller có thể bị truy cập bằng GET request

```ruby
# Cách viết cực kỳ không tốt
match ':controller(/:action(/:id(.:format)))'
```

##Controller

*  Cố gắng gọt giũa nội dung của controller. Trong controller chỉ nên thực hiện việc lấy những data mà bên view cần, không code business logic ở đây. (Những cái đó nên viết trong model)

* コントローラーの action はそれぞれ、モデルを初期化したり検索する他は1メソッドのみを実行する位が理想的である。

* Không chia sẻ giữa controller và view từ 2 biến instance trở lên.

* Cái hay của global exeption là có thể xử lý chỉ trong action của controller.

* Để tham số của render là symbol.

```ruby
render :new
```

* Không lược bỏ action ngay cả khi action đó không xử lý gì cả mà chỉ để hiển thị view

```ruby
class HomeController < ApplicationController

  def index
  end

end
```

* Đối với những action được truy cập bằng những method HTTP khác GET thì nhất định sau khi đã xử lý xong phải redirect đến một action được truy cập bằng phương thức GET. Tuy nhiên, những trường hợp mà không truy cập trực tiếp, ví dụ như chỉ là API để trả về json thì điều này không cần thiết.

**Lý do**

Ngăn chặn việc phát sinh nhiều xử lý khi mà người dùng thao tác refresh.

##Model

* Có thể sử dụng model không cần dựa trên ActiveRecord

* Cố gắng đặt tên ngắn, dễ hiểu nhưng không giản lược quá mức.

* Sử dụng gem [ActiveAttr](https://github.com/cgriego/active_attr) khi cần có những thao tác của ActiveRecord giống như validation trong model.

```ruby
class Message
  include ActiveAttr::Model

  attribute :name
  attribute :email
  attribute :content
  attribute :priority

  attr_accessible :name, :email, :content

  validates_presence_of :name
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :content, :maximum => 500
end
```

###ActiveRecord

* Phải sử dụng những database có sẵn, nếu không có lý do chính đáng thì không thay đổi những thứ mặc định của ActiveRecord như tên bảng hay là primary key.

```ruby
# Không tốt - không làm thế này nếu như có thể thay đổi thay đổi schema
class Transaction < ActiveRecord::Base
  self.table_name = 'order'
  ...
end
```

* Nhóm các macro lại, Và đặt các constant của class lên đầu tiên. Các macro cùng loại ( như là belongs_to và has_many ) hoặc là cùng macro nhưng tham số khác nhau ( ví dụ như validates ) thì sắp xếp theo thứ tự từ điển. Các callback thì sắp xếp theo thứ tự thời gian.

* Viết các macro theo thứ tự như sau:
  * các constant
  * các macro liên quan đến attr_
  * các macro quan hệ
  * validation
  * các macro callback
  * những macro khác

* scope thì viết theo cách ngắn gọn của lambda

```ruby
class User < ActiveRecord::Base
  # các constants thì cho lên đầu
  GENDERS = %w(male female)

  # tiếp theo là các macro liên quan đến attr_
  attr_accessor :formatted_date_of_birth

  attr_accessible :login, :first_name, :last_name, :email, :password

  # rồi đến các macro quan hệ
  belongs_to :country

  has_many :authentications, dependent: :destroy

  # các validation macro
  validates :email, presence: true
  validates :password, format: {with: /\A\S{8,128}\z/, allow_nil: true}
  validates :username, format: {with: /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/}
  validates :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}
  # theo thứ tự : email -> password -> username, format -> presence -> uniqueness

  # tiếp đến là các callback macro. Nên viết theo thứ tự thời gian: before -> after
  before_save :cook
  before_save :update_username_lower

  after_save :serve

  # scopes
  scope :active, ->{where(active: true)}

  # tiếp theo là các macro khác (ví dụ như macro của devise chẳng hạn)

  ...
end
```

##ActiveResource

* Trong trường hợp cần trả về response theo định dạng khác ngoài XML hay là JSON thì có thể tự tạo ra định dạng khác theo như dưới đây. Để tạo ra một định dạng khác thì cần phải định nghĩa 4 method là ``` extension ```、``` mime_type ```、``` encode ```、``` decode ```

```ruby
module ActiveResource
  module Formats
    module Extend
      module CSVFormat
        extend self

        def extension
          "csv"
        end

        def mime_type
          "text/csv"
        end

        def encode(hash, options = nil)
          # Encode dữ liệu theo định dạng mới và trả về kết quả
        end

        def decode(csv)
          # Decode dữ liệu từ định dạng mới và trả về kết quả
        end
      end
    end
  end
end

class User < ActiveResource::Base
  self.format = ActiveResource::Formats::Extend::CSVFormat

  ...
end
```

* Trong trường hợp request được gửi không có extension thì chúng ta có thể override 2 method ``` element_path ``` và ``` collection_path ``` của ``` ActiveResource::Base ```, sau đó xoá phần extension đi.

```ruby
class User < ActiveResource::Base
  ...

  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
  end

  def self.element_path(id, prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}#{collection_name}/#{URI.parser.escape id.to_s}#{query_string(query_options)}"
  end
end
```

##Migration

=======
* Quản lý phiên bản của ``` schema.rb ``` （hoặc là ``` structure.sql ```）

* Sử dụng ``` rake db:test:prepare ``` để tạo database phục vụ cho test

* Nếu cần thiết lập giá trị mặc định, thì không thiết lập tại tầng ứng dụng mà thiết lập thông qua migration

```ruby
# không tốt - gán giá trị mặc định tại tầng ứng dụng
def amount
  self[:amount] or 0
end
```

Rails 内でのみテーブルのデフォルト値を強制するのは、とても脆弱なアプローチで、アプリケーションのバグを引き起こし兼ねないと多くの開発者に指摘されている。また、非常に小さいアプリケーション以外の殆どはデータベースを他のアプリケーションと共有しており、 Rails アプリケーションからだけにデータ整合性を負わせるのは不可能である、という事実を頭に入れておく必要がある。

* 外部キー制約を強制すること。ActiveRecordは素の状態ではそれをサポートしていないが、[schema_plus](https://github.com/lomba/schema_plus)のような優れたサードパーティ製のgemがある。
* Mặc dù ActiveRecord không hỗ trợ điều này nhưng mà có thể dùng gem của bên thứ 3 như [schema_plus](https://github.com/lomba/schema_plus).

* Để thay đổi cấu trúc bảng như thêm column thì viết theo cách mới của Rails 3.1. Tóm lại, không sử dụng ``` up ``` hoặc ``` down ``` mà sử dụng ``` change ```.

```ruby
# cách viết cũ
class AddNameToPerson < ActiveRecord::Migration
  def up
    add_column :persons, :name, :string
  end

  def down
    remove_column :person, :name
  end
end

# cách viết mới tiện hơn
class AddNameToPerson < ActiveRecord::Migration
  def change
    add_column :persons, :name, :string
  end
end
```

* モデルのクラスをマイグレーション内で使ってはいけない。モデルのクラスは常に進化するので、モデルを使っている箇所の変更により、将来のある時点でマイグレーション処理が止まってしまう可能性がある。
* Trong migration không sử dụng model class. Tại vì model class thì rất dễ bị thay đổi, thêm vào, khi đó xử lý của migration trước đây có thể bị ảnh hưởng.

##View

* Không gọi trực tiếp model trong view, mà phải sử dụng thông qua controller hoặc helper.

* Không viết các xử lý phức tạp trong view. Những xử lý phức tạp thì nên đặt trong các view helper hoặc trong model.

* Sử dụng partial hoặc layout để tránh việc viết lại code

* Sử dụng helper để viết form. Các đoạn code có chứa logic hoặc thiết lập như đọc file ngoài hoặc link thì cũng phải sử dụng helper.

* Không sử dụng form_tag khi mà có thể sử dụng form_for.

* Cân nhắc sử dụng [client side validation](https://github.com/bcardarella/client_side_validations). Cách sử dụng như dưới đây.
  * Khai báo custom validator kế thừa ``` ClientSideValidations::Middleware::Base ```

```ruby
module ClientSideValidations::Middleware
  class Email < Base
    def response
      if request.params[:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end
```

  * Tạo file ``` public/javascripts/rails.validations.custom.js.coffee ```、và thêm tham chiếu đến file vừa tạo vào ``` application.js.coffee ```.

```coffee
# app/assets/javascripts/application.js.coffee
#= require rails.validations.custom
```

  * Thêm validator của bên client.

```coffee
#public/javascripts/rails.validations.custom.js.coffee
clientSideValidations.validators.remote['email'] = (element, options) ->
  if $.ajax({
    url: '/validators/email.json',
    data: { email: element.val() },
    async: false
  }).status == 404
    return options.message || 'invalid e-mail format'
```

##Quốc tế hoá 国際化

* モデル、ビュー、コントローラーいずれの中でも特定の言語や国に依存した設定を含めてはいけない。それらの文章等は ``` config/locales ``` ディレクトリ内のロケールファイルに記述すること。

* ActiveRecord モデルのラベルを翻訳する必要があるときは、 ``` activerecord ``` スコープに記載する。

```yaml
ja:
  activerecord:
    models:
      user: メンバー
    attributes:
      user:
        name: 姓名
```

その時、``` User.model_name.human ``` は"メンバー"と返し、``` User.human_attribute_name("name") ``` は"姓名"と返す。このような翻訳はビューの中でも使うことができる。

* ActiveRecord の属性を翻訳したものと、ビューの中で使われるものとはファイルを分ける。モデルに利用するファイルは ``` models ``` フォルダーにおいて、ビューに利用するものは ``` views ``` フォルダーに保存する。
  * ファイルを追加したらロケールファイルが読み込まれるディレクトリを ``` application.rb ``` に追加する。

```ruby
# config/application.rb
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
```

* 日付や通貨のフォーマットのように共通で使うものは ``` locales ``` ディレクトリ直下に保存する。

* 短縮表記のメソッドを使うようにする。 ``` I18n.t ``` を ``` I18n.translate ``` の代わりに使い、``` I18n.l ``` を ``` I18n.localize ``` の代わりに使う。

* ビューの中では Lazy lookup を使う。このような構造のとき、
```yaml
ja:
  users:
    show:
      title: "ユーザー情報"
```
``` users.show.title ``` は ``` app/views/users/show.html.haml ``` 内では
```ruby
= t '.title'
```
で取得できる。

* コントローラーやモデルの中では ``` :scope ``` 指定では無く、ドット区切りのキーで値を取得する。ドット区切りの方が簡単に呼べ、階層を追いやすい。

```ruby
# use this call
I18n.t 'activerecord.errors.messages.record_invalid'

# instead of this
I18n.t :record_invalid, :scope => [:activerecord, :errors, :messages]
```

* Cụ thể theo như [RailsGuide](http://guides.rubyonrails.org/i18n.html).

##Asset

Sử dụng asset pipeline

* Stylesheet, javascript, hay image của ứng dụng thì cho vào ``` app/assets ```.

* Những file như thư viện thì cho vào ``` lib/assets ```. Thế nhưng những file thư viện mà đã chỉnh sửa cho phù hợp với ứng dụng của mình thì không cho vào đây.

* Những sản phẩm thirdparty như jQuery hoặc bootstrap thì lưu trong ``` vendor/asstes ```.

* Nếu có thể thì nên sử dụng những gem của asset. (ví dụ：[jquery-rails](https://github.com/rails/jquery-rails)）。

* Trong CSS khi viết url thì dùng asset_url.

##Mailer

* Đối với mailer thì đặt tên giống như ``` SomethingMailer ```. Như thế sẽ hiểu được mail gửi nội dung gì và liên quan đến view nào.

* Viết cả hai loại template  HTML và plaintext.

* Trong môi trường developer thì cho xuất hiện lỗi khi gửi mail không thành công. Thiết lập mặc định là không xuất hiện lỗi nên cần phải chú ý.

```ruby
# config/environments/development.rb
config.action_mailer.raise_delivery_errors = true
```

* Nhất định phải thiết lập host

```ruby
# config/environments/development.rb
config.action_mailer.default_url_options = {host: "localhost:3000"}

# config/environments/production.rb
config.action_mailer.default_url_options = {host: 'your_site.com'}

# trong class mailer của bạn
default_url_options[:host] = 'your_site.com'
```

* Khi mà cần gán link đến trang của mình trong mail thì không dùng method ``` _path ``` mà phải dùng ``` _url ```. Bởi vì ``` _url ``` có chứa hostname nhưng ``` _path ``` thì không.

```ruby
# sai
You can always find more info about this course
= link_to 'here', url_for(course_path(@course))

# đúng
You can always find more info about this course
= link_to 'here', url_for(course_url(@course))
```

* Thiết lập chính xác địa chỉ của From và To. Sử dụng khuôn mẫu như dưới đây.

```ruby
# trong class mail của bạn
default from: 'Your Name <info@your_site.com>'
```

* Đối với môi trường test thì không quên thiết lập `` test ``` cho phương thức gửi mail

```ruby
# config/environments/test.rb
config.action_mailer.delivery_method = :test
```

* Đối với môi trường development hoặc production thì thiết lập ``` smtp ``` là phương thức gửi mail

```ruby
# config/environments/development.rb, config/environments/production.rb
config.action_mailer.delivery_method = :smtp
```

* Bởi vì có những mail client xuất hiện lỗi với external CSS thế nên khi gửi HTML mail thì chỉ định inline css cho tất cả style. Thế nhưng, làm như thế dẫn đến khó bảo trì và việc lặp lại code. Để đối phó với vấn đề này thì chúng ta có thể dùng [premailer-rails3](https://github.com/fphilipe/premailer-rails3) hoặc [roadie](https://github.com/Mange/roadie).

* Cần tránh việc gửi mail khi trang đang được tạo. Bởi vì có thể xảy ra request timeout khi nhiều mail được gửi hoặc độ trễ của việc load trang. Để giải quyết vấn đề đó thì có thể dùng [delayed_job](https://github.com/tobi/delayed_job).

##Bundler

* Những gem mà chỉ dùng trong môi trường development hoặc test thì phải viết trong nhóm tương ứng.

* Chỉ sử dụng những gem thực sự cần thiết. Những gem mà không nổi tiếng thì khi dùng cần phải xem xét kỹ.

* Đối với những gem mà có những phụ thuộc vào loại OS nhất định khi vận hành trên OS khác thì Gemfile.lock sẽ bị sửa lại. Vì vậy nên nhóm các gem cho OS X trong nhóm ``` darwin ```, và các gem cho Linux trong nhóm ``` linux ```

```ruby
# Gemfile
group :darwin do
  gem 'rb-fsevent'
  gem 'growl'
end

group :linux do
  gem 'rb-inotify'
end
```

Để load được gem thích hợp vào môi trường chính xác thì viết như sau vào file ``` config/application.rb ```

```ruby
platform = RUBY_PLATFORM.match(/(linux|darwin)/)[0].to_sym
Bundler.require(platform)
```

* Không xoá ``` Gemfile.lock ``` trong version management system. これは確率論的に変更されるファイルではなく、どのチームメンバーが ``` bundle instal    l ``` しても全ての gem のバージョンが揃うために必要である。
