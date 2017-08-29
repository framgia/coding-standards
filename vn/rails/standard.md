# Các quy định về viết code Ruby on Rails (Tập các kiểu chuẩn)

## Thiết lập

* Những thiết lập của ứng dụng đặt trong thư mục ``` config/initializers ```. Những đoạn code được đặt trong này sẽ được chạy khi ứng dụng khởi tạo.

* Đối với những file code khởi tạo của các gem như ``` carierwave.rb ``` hoặc ``` active_admin.rb ``` thì đặt tên file giống tên gem.

* Những thiết lập cho từng môi trường development, test, production thì thiết lập trong các file tương ứng trong thư mục ``` config/environments ```

* Thiết lập cho tất cả môi trường thì viết vào ``` config/application.rb ```

* Trong trường hợp tạo môi trường mới như staging thì cố gắng thiết lập gần giống môi trường production

## Routing

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

## Controller

*  Cố gắng gọt giũa nội dung của controller. Trong controller chỉ nên thực hiện việc lấy những data mà bên view cần, không code business logic ở đây. (Những cái đó nên viết trong model)

* Mỗi action trong controller thì lý tưởng là 1 method initialize model , 1 method seach , 1 method thực hiện tác vụ gì đó.

* Không chia sẻ giữa controller và view từ 2 biến instance trở lên.

* Đối với biến instance biểu thị resource chính ở Controller, hãy gán vào object của resource đó. Ví dụ, đối với `@article` ở bên trong ArticlesController thì gán instance của class `Article` vào. Với `@articles` thì gán collection của nó vào.

```ruby
# Không tốt
class ArticlesController < ApplicationController
  def index
    @articles = Article.all.pluck [:id, :title]
  end

  def show
    @article = "This is an article."
  end
end

# Tốt
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
  end
end
```

* Controller cần xử lý ngoại lệ xuất hiện tại model. Cần phải thông báo việc xuất hiện ngoại lệ bằng cách gửi đến client code 400 trở lên.

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

* Trong hàm callback nên sử dụng tên method hoặc ```lamda```. Không được sử dụng block ở đây.


```ruby
# cách viết không tốt

  before_action{@users = User.all} # brock

# cách viết tốt

  before_action :methodname # method name

# cách viết cũng tốt

  before_action ->{@users = User.all} # lambda
```

## Model

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

### ActiveRecord

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

#### Scope
* Đặt tên scope thể hiện việc lấy một tập hợp con trong tập hợp bản ghi cha. 
* Hãy đặt tên scope sao cho có thể hiểu được một cách tự nhiên như sau 
`[số nhiều của tên model] có đặc tính [tên scope]`. 
(Ví dụ: với việc đặt tên scope là `active` trong model user có thể hiểu 
            Hãy lấy ra các `[users] có đặc tính [active]`.)
* Trong trường hợp có đối số, hãy kết hợp tên scope và đối số sao cho thật tự nhiên và dễ hiểu. 
* Cố gắng tránh việc đặt tên scope có bao gồm tên model. 

```ruby
# Không tốt
class User < ActiveRecord::Base
  scope :active_users, ->{where activated: true}
end
class Post < ActiveRecord::Base
  scope :by_author, ->author{where author_id: author.id}
end

# Tốt
class User < ActiveRecord::Base
  scope :active, ->{where activated: true}
end
class Post < ActiveRecord::Base
  scope :posted_by, ->author{where author_id: author.id}
end
```

* scope thì viết theo cách ngắn gọn của lambda. Nếu trong 1 dòng mà quá 80 kí tự thì nên cắt xuống dòng mới thích hợp để cho 1 dòng chỉ nên ít hơn 80 kí tự.

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

* Không dùng ``` default_scope ``` ngoài việc liên quan đến xoá logic. Ngoài ra trong trường hợp này không được dùng ``` order ```.

* Một khi đã dùng `has_many` hoặc `has_one` đối với một model thì nhất định phải khai báo `belongs_to` với model tương ứng.

## ActiveResource

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

## Migration

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

Việc thiết lập giá trị mặc định của các bảng chỉ trong ứng dụng là cách làm tạm bợ, có thể sinh ra lỗi trong ứng dụng. Hơn nữa, ngoại trừ những ứng dụng khá nhỏ thì hầu như các ứng dụng đều chia sẻ database với các ứng dụng khác, thế nên nếu chỉ thiết lập trong ứng dụng thì tính nhất quán của dữ liệu sẽ không còn được đảm bảo.

* Quy định ràng buộc khoá ngoài. Mặc dù ActiveRecord không hỗ trợ điều này nhưng mà có thể dùng gem của bên thứ 3 như [schema_plus](https://github.com/lomba/schema_plus).

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

* Không sử dụng class của model trong migration. Tại vì model class thì rất dễ bị thay đổi, khi đó xử lý của migration trước đây có thể bị ảnh hưởng.

## View

* Không gọi trực tiếp model trong view, mà phải sử dụng thông qua controller hoặc helper.

* Tuy nhiên vẫn có ngoại lệ cho phép trực tiếp gọi Model trong View như một master cho các thẻ như thẻ Select.

* Không viết các xử lý phức tạp trong view. Những xử lý phức tạp thì nên đặt trong các view helper hoặc trong model.

* Sử dụng partial hoặc layout để tránh việc viết lại code

* Sử dụng helper để viết form. Các đoạn code có chứa logic hoặc thiết lập như đọc file ngoài hoặc link thì cũng phải sử dụng helper.

* Không sử dụng form_tag khi mà có thể sử dụng form_for.

* Thêm 1 space bên trong các ``` <% ``` , ``` <%= ``` と ``` %> ```.

```ruby
#Cách viết không tốt
<%foo%>
<% bar%>
<%=bar%>
<%=bar %>

#Cách viết tốt
<% foo %>
<%= bar %>
 ```


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

## Đa ngôn ngữ

* Không đặt các thiết lập phụ thuộc vào ngôn ngữ, quốc gia vào model, controller, view. Những thiết lập này đặt trong ``` config/locales ```.

* Khi cần dịch các nhãn (label) của ActiveRecord model thì viết vào ``` activerecord ``` scope như dưới đây.

```yaml
ja:
  activerecord:
    models:
      user: メンバー
    attributes:
      user:
        name: 姓名
```

Khi đó, ``` User.model_name.human ``` sẽ trả về "メンバー", ``` User.human_attribute_name("name") ``` sẽ trả về "姓名". Kiểu dịch như thế này cũng có thể sử dụng được trong view.

* Chia những đoạn dịch các thuộc tính của ActiveRecord và những đoạn được dùng trong view thành các file riêng biệt. File nào được dùng trong model thì đặt trong thư mục ``` models ```, file nào được dùng trong view đặt trong thư mục ``` views ```.

  * Sửa lại file ``` application.rb ``` để load các file trong locales khi thêm file vào thư mục này.

```ruby
# config/application.rb
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
```

* Đặt những thứ dùng chung như các định dạng của ngày tháng, tiền tệ ngay bên trong thư mục ``` locales ```.

* Sử dụng những method tên ngắn hơn. Sử dụng ``` I18n.t ``` thay cho ``` I18n.translate ```, ``` I18n.l ``` thay cho  ``` I18n.localize ```.

* Sử dụng Lazy lookup trong view. Ví dụ nếu chúng ta có cấu trúc như sau:
```yaml
ja:
  users:
    show:
      title: "ユーザー情報"
```
thì giá trị của ``` users.show.title ``` có thể lấy được trong ``` app/views/users/show.html.haml ``` bằng cách viết ngắn gọn như sau:
```ruby
= t '.title'
```

* Trong controller và model thì không dùng ``` :scope ``` mà thay vào đấy ta dùng dấu chấm (.) để lấy các giá trị mình muốn. Việc dùng dấu chấm sẽ đơn giản hơn và dễ hiểu hơn.

```ruby
# sử dụng cách viết này
I18n.t 'activerecord.errors.messages.record_invalid'

# thay cho cách viết dưới đây
I18n.t :record_invalid, :scope => [:activerecord, :errors, :messages]
```

* Thông tin chi tiết có thể tham khảo tại [RailsGuide](http://guides.rubyonrails.org/i18n.html).

## Asset

Sử dụng asset pipeline

* Stylesheet, javascript, hay image của ứng dụng thì cho vào ``` app/assets ```.

* Những file như thư viện thì cho vào ``` lib/assets ```. Thế nhưng những file thư viện mà đã chỉnh sửa cho phù hợp với ứng dụng của mình thì không cho vào đây.

* Những sản phẩm thirdparty như jQuery hoặc bootstrap thì lưu trong ``` vendor/asstes ```.

* Nếu có thể thì nên sử dụng những gem của asset. (ví dụ：[jquery-rails](https://github.com/rails/jquery-rails)）。

* Trong CSS khi viết url thì dùng asset_url.

## Mailer

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

## Bundler

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

* Không xoá ``` Gemfile.lock ``` trong version management system. File này nhằm đảm bảo môi trường phát triển của developer nào cũng chạy gem cùng phiên bản khi ``` bundle install ```.
