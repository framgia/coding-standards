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

* 大域脱出を行って良いのはコントローラーの action 内のみとする。

* render の引数は シンボルとする。

```ruby
render :new
```

* GET 以外の HTTP メソッドでアクセスされる action は必ず、処理完了後、 GET メソッドでアクセスされる action へリダイレクトさせる。ただし、直接人がアクセスするものではない、 json を返却する API のようなものはその必要はない。

**理由**

ユーザーのリフレッシュ操作による多重処理を防止するため。

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
  self.table_name = 'order'
  ...
end
```

* マクロメソッドはまとめてクラス定義の初期に書く。同種のマクロメソッド（ belongs_to と has_many 等）や同じマクロメソッドで種々の引数を持つものの引数（ validates 等）は辞書順に並べる。

* マクロメソッドは

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


