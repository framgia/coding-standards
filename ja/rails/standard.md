#Ruby on Rails コーデング規約（標準スタイル編）

##設定

* アプリケーション固有の設定は ``` config/initializers ``` に置く。ここに置いたcodeはアプリケーションが起動するときに実行される。

* 初期化のcodeは``` carierwave.rb ``` や ``` active_admin.rb ``` のようにgemごとにgemと同じ名前でファイルを作成する。

* development、test、productionで環境ごとに異なるものは``` config/environments ``` にファイルを切り出す等して調整する。

* 全ての環境で有効にするものは ``` config/application.rb ``` に記載する。

* stagingのような新しい環境を作成した場合は、なるべく production と近づけるようにする。

##ルーティング

* RESTfulなリソースにactionを追加する必要があるときは、``` member ``` と ``` collection ``` を使う。

```ruby
# bad
get 'subscriptions/:id/unsubscribe'
resources :subscriptions

# good
resources :subscriptions do
  get 'unsubscribe', on: :member
end

# bad
get 'photos/search'
resources :photos

# good
resources :photos do
  get 'search', on: :collection
end
```

* 複数の ``` member/collection ``` がある時はblockで記述する。

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

* ActiveRecord のモデルの relation を表現するために nested routesを利用する。

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

* 関係するactionをグループ化するために、namespace を利用する。

```ruby
namespace :admin do
  # Directs /admin/products/* to Admin::ProductsController
  # (app/controllers/admin/products_controller.rb)
  resources :products
end
```

* 旧型のwild controller route は使ってはいけない。

**理由**

この書き方をすると全ての controller の action が GET リクエストでアクセスできてしまうため。

```ruby
# very bad
match ':controller(/:action(/:id(.:format)))'
```

##コントローラー

* コントローラーはギリギリまで中身を削ること。view が必要とするデータの取得のみを行うべきで、決してビジネスロジックを記載してはいけない。（それはモデルで行うべきである）

* コントローラーの action はそれぞれ、モデルを初期化したり検索する他は1メソッドのみを実行する位が理想的である。

* 2個以上のインスタンス変数をコントローラーとviewの間で共有してはいけない。

* コントローラにおけるメインのリソースを示すインスタンス変数には、そのリソースのオブジェクトをアサインすること。例えば、ArticlesController内の `@article` には `Article` クラスのインスタンスをアサインする。 `@articles` には、そのコレクションをアサインする。

```ruby
# bad
class ArticlesController < ApplicationController
  def index
    @articles = Article.all.pluck [:id, :title]
  end

  def show
    @article = "This is an article."
  end
end

# good
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
  end
end
```

* モデル等が発生させた Exception はコントローラーが必ず処理をする。コントローラーは Exception を受け取ったらステータスコード 400 以上をクライアントに通知することで、 Exception の発生を通知しなければならない。

* render の引数は シンボルとする。

```ruby
render :new
```

* 処理を行わず、View を表示するだけのアクションも省略しない。

```ruby
class HomeController < ApplicationController

  def index
  end

end
```

* GET 以外の HTTP メソッドでアクセスされる action は必ず、処理完了後、 GET メソッドでアクセスされる action へリダイレクトさせる。ただし、直接人がアクセスするものではない、 json を返却する API のようなものはその必要はない。

**理由**

ユーザーのリフレッシュ操作による多重処理を防止するため。

* コールバックの記述には、メソッド名か ```lambda``` を使うこと。ここにブロックを使ってはいけない。

```ruby
# bad

  before_action{@users = User.all} # brock

# good

  before_action :methodname # method name

# also good

  before_action ->{@users = User.all} # lambda
```

##モデル

* ActiveRecord 以外のモデルも自由に利用して良い。

* 短縮や省略を用いることなく、分かり易く、でも短い名前を付けるようにする。

* validation など ActiveRecord の振る舞いをモデルに持たせる必要があるとき、[ActiveAttr](https://github.com/cgriego/active_attr) gem を利用する。

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

* 既存のデータベースを利用しなければならない、等の正当な理由が無い場合はテーブル名やプライマリーキー等、ActiveRecordのデフォルトを変更してはいけない。

```ruby
# bad - don't do this if you can modify the schema
class Transaction < ActiveRecord::Base
  @table_name = :order
  ...
end
```

* どうしても必要で ``` primary_key ``` や ``` table_name ``` を明示的に指定するときは、クラス変数を直接書き換える。これらの定義はマクロメソッドの前に記述する。

```ruby
class Transaction < ActiveRecord::Base
  @primary_key= :order_id
  @table_name = :order
  ...
end
```

**理由**
クラスのプロパティを書き換えていることを明示的に示すため。本来行うべきでない処理を行っていることを明示的に示すため。

* マクロメソッドはまとめてクラス定義の初期に書く。同種のマクロメソッド（ belongs_to と has_many 等）や同じマクロメソッドで種々の引数を持つものの引数（ validates 等）は辞書順に並べる。callback は時系列に並べる。

* マクロメソッド等の記述順は、
  * 定数
  * attr_ 系メソッド
  * 関連
  * バリデーション
  * callback
  * その他

の順に記載する。

* scope は lambda の省略記法で記述する。この場合も1行の長さが80文字以上になる場合は適宜改行する等して、80文字以内に納めるようにする。

```ruby
class User < ActiveRecord::Base
  # constants come up next
  GENDERS = %w(male female)

  # afterwards we put attr related macros
  attr_accessor :formatted_date_of_birth

  attr_accessible :login, :first_name, :last_name, :email, :password

  # followed by association macros
  belongs_to :country

  has_many :authentications, dependent: :destroy

  # and validation macros
  validates :email, presence: true
  validates :password, format: {with: /\A\S{8,128}\z/, allow_nil: true}
  validates :username, format: {with: /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/}
  validates :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}
  # email -> password -> username, format -> presence -> uniqueness

  # next we have callbacks, callbaks should be sorted by chronological order: before -> after
  before_save :cook
  before_save :update_username_lower

  after_save :serve

  # scopes
  scope :active, ->{where(active: true)}

  # other macros (like devise's) should be placed after the callbacks

  ...
end
```

* ``` default_scope ``` は論理削除状態を表現する以外の目的で使ってはならない。また、その時も ``` order ``` を使ってはいけない。

* `has_many` または `has_one` で指定されたモデルは必ず相手を `belongs_to` で指定する。


##ActiveResource

* XML や JSON （もちろん HTML も）以外の既存のフォーマット以外のレスポンスを返す必要があるときは、下記のように独自のカスタムフォーマットを作成して利用する。カスタムフォーマットを実装するには、``` extension ```、``` mime_type ```、``` encode ```、``` decode ``` の4つのメソッドを定義する必要がある。

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
          # Encode the data in the new format and return it
        end

        def decode(csv)
          # Decode the data from the new format and return it
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

* もしリクエストが拡張子無しで送られるようにするのであれば、``` ActiveResource::Base ``` の ``` element_path ``` と ``` collection_path ``` の2つのメソッドをオーバーライドして、extension の部分を削除すれば良い。

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

##マイグレーション

=======
* ``` schema.rb ``` （または ``` structure.sql ```）はバージョン管理する

* テスト用のデータベースを作成するために ``` rake db:test:prepare ``` を用いること

* デフォルト値を設定する必要があるならば、アプリケーションレイヤーではなくマイグレーションで対応すること。

```ruby
# bad - application enforced default value
def amount
  self[:amount] or 0
end
```

Rails 内でのみテーブルのデフォルト値を強制するのは、とても脆弱なアプローチで、アプリケーションのバグを引き起こし兼ねないと多くの開発者に指摘されている。また、非常に小さいアプリケーション以外の殆どはデータベースを他のアプリケーションと共有しており、 Rails アプリケーションからだけにデータ整合性を負わせるのは不可能である、という事実を頭に入れておく必要がある。

* 外部キー制約を強制すること。ActiveRecordは素の状態ではそれをサポートしていないが、[schema_plus](https://github.com/lomba/schema_plus)のような優れたサードパーティ製のgemがある。

* テーブルやカラムを追加するよな、構成を変更する処理の記述には Rails 3.1 記法を用いること。つまり、``` up ``` や ``` down ``` メソッドではなく、``` change ``` メソッドを使うこと。

```ruby
# the old way
class AddNameToPerson < ActiveRecord::Migration
  def up
    add_column :persons, :name, :string
  end

  def down
    remove_column :person, :name
  end
end

# the new prefered way
class AddNameToPerson < ActiveRecord::Migration
  def change
    add_column :persons, :name, :string
  end
end
```

* モデルのクラスをマイグレーション内で使ってはいけない。モデルのクラスは常に進化するので、モデルを使っている箇所の変更により、将来のある時点でマイグレーション処理が止まってしまう可能性がある。

##ビュー

* ビューの中でモデルを直接呼んではいけない。コントローラーにインスタンス化させるか、ヘルパー内で利用する。

* select タグなどのためのマスターとして View の中でモデルを直接呼ぶのは例外的に許可することとする。

* ビュー内で複雑な処理を記載しない。複雑な処理が必要であればビューヘルパーに切り出すか、モデル内で処理させる。

* 同じコードを記述することを避けるために、パーシャルやレイアウトを利用する。

* form は helper を用いて記述しなければならない。リンクや外部ファイルの読み込み等、ロジックや設定が含まれるものの記述も helper を使う。

* form_for が利用できる時は form_tag を用いてはいけない。

* ``` <% ``` 、 ``` <%= ``` と ``` %> ``` の内側にホワイトスペースを1つ入れる。

```ruby
#bad
<%foo%>
<% bar%>
<%=bar%>
<%=bar %>

#good
<% foo %>
<%= bar %>
```


* [client side validation](https://github.com/bcardarella/client_side_validations)の利用を検討する。使い方は下記のとおり。
  * ``` ClientSideValidations::Middleware::Base ``` を継承したカスタムバリデーターを宣言する。

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

  * ``` public/javascripts/rails.validations.custom.js.coffee ``` ファイルを作成して、``` application.js.coffee ``` ファイルに参照を追加する。

```coffee
# app/assets/javascripts/application.js.coffee
#= require rails.validations.custom
```

  * クライアント側のバリデーターを追加する。

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

##国際化

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

* 詳細は [RailsGuide](http://guides.rubyonrails.org/i18n.html)に従う。

##アセット

asset pipeline を利用する

* アプリケーション固有のスタイルシートやJavascript、画像等は ``` app/assets ``` へ入れる。

* ``` lib/assets ``` はライブラリ的なファイルを入れる。ライブラリでも、アプリケーション固有に調整したものは入れない。

* jQuery や bootstrap のようなサードパーティ製品は ``` vendor/asstes ``` に保存する。

* 可能であれば、gem 化されたアセットを利用する。（例：[jquery-rails](https://github.com/rails/jquery-rails)）。

* CSS の中に url を記載するときは asset_url を使うこと。

##メイラー

* メイラーは ``` SomethingMailer ``` のような名前にする。Mailerという接尾語を外せば、それがどのようなメールを送ってどのviewが関連するのかが一目瞭然なようにする。

* HTML とプレインテキストの両方のテンプレートを用意する。

* development 環境ではメール送信に失敗したときにエラーが起こるようにする。デフォルトでは無効になっているので気をつけること。

```ruby
# config/environments/development.rb
config.action_mailer.raise_delivery_errors = true
```

* host オプションは必ず設定する。

```ruby
# config/environments/development.rb
config.action_mailer.default_url_options = {host: "localhost:3000"}

# config/environments/production.rb
config.action_mailer.default_url_options = {host: 'your_site.com'}

# in your mailer class
default_url_options[:host] = 'your_site.com'
```

* メールの中でサイトへリンクさせる時には、``` _path ``` ではなく ``` _url ``` メソッドを利用する。``` _url ``` メソッドはホスト名を含み、``` _path ``` は含まないからである。

```ruby
# wrong
You can always find more info about this course
= link_to 'here', url_for(course_path(@course))

# right
You can always find more info about this course
= link_to 'here', url_for(course_url(@course))
```

* From と To アドレスは正しく設定する。下記の形式を利用すること。

```ruby
# in your mailer class
default from: 'Your Name <info@your_site.com>'
```

* テスト環境ではメール送信メソッドに ``` test ``` を忘れずに設定すること。

```ruby
# config/environments/test.rb
config.action_mailer.delivery_method = :test
```

* development 環境や production 環境等では送信メソッドを ``` smtp ```にする。

```ruby
# config/environments/development.rb, config/environments/production.rb
config.action_mailer.delivery_method = :smtp
```

* 外部CSSで問題が起きるメールクライアントがあるので、HTML メールを送る時は全てのstyleをインラインで指定する。しかしながら、そうするとメンテナンスしづらく、コードの重複が置きやすくなる。この問題は[premailer-rails3](https://github.com/fphilipe/premailer-rails3)や[roadie](https://github.com/Mange/roadie)がサポートしてくれる。

* ページを作成している途中でメールを送るのは避けるべきである。それはページ読み込みの遅延や複数のメールを送った時には、リクエストタイムアウトの原因になることがある。これらの問題を解決するために、[delayed_job](https://github.com/tobi/delayed_job)を使うと良い。

##バンドラー

* development 環境や test 環境でのみ利用する gem は適切なグループを設定して記述する。

* 本当に必要な gem のみを利用する。あまり有名でない gem を利用する時は、最初に細心の注意を払ってレビューを行うべきである。

* OS 固有の gem は稼働させる OS が異なる度に Gemfile.lock を書き換えるため、OS X 固有の gem は ``` darwin ``` グループに、Linux 固有の gem は ``` linux ``` グループに記載する。

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

適切な gem が正しい環境で読み込まれるように、``` config/application.rb ``` に下記のように記述する。

```ruby
platform = RUBY_PLATFORM.match(/(linux|darwin)/)[0].to_sym
Bundler.require(platform)
```

* バージョン管理システムから ``` Gemfile.lock ``` を削除してはいけない。これは確率論的に変更されるファイルではなく、どのチームメンバーが ``` bundle install ``` しても全ての gem のバージョンが揃うために必要である。
