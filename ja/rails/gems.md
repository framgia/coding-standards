#Ruby on Rails 標準 gem 一覧

最も大事なプログラミングの原則の１つに"Don't Repeat Yourself!"がある。もし、何か必要な作業に直面したら、それを自力で解決する前に何か解決方法が存在しないかを探すべきである。これは「とても価値のある」 gem の一覧で、多くの Rails プロジェクトで有意義なものだろう。全て Rails 3.1 で動作する。

##管理画面作成

* [active_admin](https://github.com/gregbell/active_admin) - 簡単に管理画面を作成できる。各モデルのCRUD処理も簡単に作成でき、カスタマイズも柔軟にできる。

##開発環境、テスト環境改善

**注意：これらは production に適用してはならない**

* [capybara](https://github.com/jnicklas/capybara) - Capybara は Rails や Sinatra、 Merb といった Rack アプリケーションの統合テストを簡単にできるようにするものである。Webアプリケーションでの実際のユーザーの操作をシミュレーションする。現在ビルトインされた Rack::Test と Selenium をサポートしていて、テストを走らせるドライバーとして使える。HtmlUnit や Webkit、env.js も gem を導入することで利用可能になる。RSpec と Cucmber と共に用いると非常に有用である。

* [better_errors](https://github.com/charliesome/better_errors) - 標準のエラーページを、より使いやすいものに差し替える。Rack ミドルウエアとして Rails 以外の Rack アプリケーションで利用できる。

* [cucumber-rails](https://github.com/cucumber/cucumber-rails) - Ruby で結合テストを行うための非常に優れたツールである。cucumber-rails を導入すると Cucumber を Rails で利用できるようになる。

* [factory_girl](https://github.com/thoughtbot/factory_girl) - テスト等のためのオブジェクト生成を助けてくれる。

* [ffaker](https://github.com/EmmanuelOga/ffaker) - 簡単にダミーデータを作成してくれる。

* [guard](https://github.com/guard/guard) - ファイルの変更を監視してタスクを自動実行することができる。様々な有用なツールに利用されている。

* [spork](https://github.com/sporkrb/spork) - Rspec や Cucumber などのテストフレームワークのための DRb サーバーで、綺麗な状態でテストができるように準備してくれる。テストの実行環境を先読みすることで、テストの実行時間を大幅に削減してくれる。

* [simplecov](https://github.com/colszowka/simplecov) - Ruby 1.9 で利用できるコードカバレッジツール。

* [rspec-rails](https://github.com/rspec/rspec-rails) - Rails で RSpec を利用しやすくする。

##パフォーマンス改善

* [bullet](https://github.com/flyerhzm/bullet) - 発行するクエリの数を減らすことでアプリケーションのパフォーマンスを向上するように設計されている。アプリケーションを監視して、先読み（N+1 queries）すべきところや、不要なのに先読みしているところ、カウンターキャッシュを利用すべきところを教えてくれる。

##ファイルアップロード

* [Paperclip](https://github.com/thoughtbot/paperclip) - ActiveRecord にファイルを添付することができる。

##全文検索

* [sunspot](https://github.com/sunspot/sunspot) - SOLR を利用した全文検索システム。

##権限管理

* [cancan](https://github.com/ryanb/cancan) - ユーザーがリソースにアクセスすることを制限することができるようになる。全ての権限を一つのファイルで管理して、アプリケーション全体で認証を利用可能にする。

* [devise](https://github.com/plataformatec/devise) - ほぼ全ての機能を備えた認証ソリューション。

##ビューテンプレート

* [haml-rails](https://github.com/indirect/haml-rails) - Rails で HAML を利用できるようにする。

* [haml](http://haml-lang.com) - HAML は ERB より圧倒的に優れているとみなされている簡潔なテンプレート言語である。

* [slim](http://slim-lang.com) - Slim は ERB はもとより、HAML よりも優れていると言われるテンプレート言語である。Slim の使用をためらう理由があるとしたら、メジャーなエディターや IDE が十分にサポートしていない位である。また、パフォーマンスが著しく良い。

##クライアントサイドサポート

* [client_side_validations](https://github.com/bcardarella/client_side_validations) - サーバーサイドに実装したモデルのバリデーションからクライアントサイドで動く Javascript のバリデーションを自動生成する。

##SEO対策

* [friendly_id](https://github.com/norman/friendly_id) - モデルの id の代わりに人が理解しやすい、記述的な属性でオブジェクトを指定刷ることができる。

##ページネーション

* [kaminari](https://github.com/amatsuda/kaminari) - 柔軟なページネーションが可能。

##画像編集

* [minimagick](https://github.com/probablycorey/mini_magick) - ImageMagick の Ruby ラッパー。

##（標準にするか未定）

* [simplecov-rcov](https://github.com/fguillen/simplecov-rcov) - RCov formatter
  for SimpleCov. Useful if you're trying to use SimpleCov with the Hudson
  contininous integration server.

* [carrierwave](https://github.com/jnicklas/carrierwave) - the ultimate file
  upload solution for Rails. Support both local and cloud storage for the
  uploaded files (and many other cool things). Integrates great with
  ImageMagick for image post-processing.

* [compass-rails](https://github.com/chriseppstein/compass) - Great gem that
  adds support for some css frameworks. Includes collection of sass mixins that
  reduces code of css files and help fight with browser incompatibilities.

* [fabrication](http://fabricationgem.org/) - a great fixture replacement
  (editor's choice).

* [feedzirra](https://github.com/pauldix/feedzirra) - Very fast and flexible
  RSS/Atom feed parser.

* [globalize3](https://github.com/svenfuchs/globalize3.git) - Globalize3 is
  the successor of Globalize for Rails and is targeted at ActiveRecord
  version 3.x. It is compatible with and builds on the new I18n API in Ruby
  on Rails and adds model translations to ActiveRecord.

* [machinist](https://github.com/notahat/machinist) - Fixtures aren't fun.
  Machinist is.

* [simple_form](https://github.com/plataformatec/simple_form) - once you've
  used simple_form (or formtastic) you'll never want to hear about Rails's
  default forms. It has a great DSL for building forms and no opinion on
  markup.

* [email-spec](https://github.com/bmabey/email-spec) - RSpec や Cucumber で email のテストを行いやすくする。

##非推奨 gem

これらの gem は問題を抱えているか、他に優れた代替 gem があるものである。これらの gem の使用は避けるべきである。

* [rmagick](http://rmagick.rubyforge.org/) - メモリーを無駄に使うので利用すべきでない。代わりに minimagick を利用すべきである。

* [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/) - 自動テストツール。さらに優れている guard を利用すべきである。

* [rcov](https://github.com/relevance/rcov) - Ruby 1.9 に対応していない。simplecov を利用すべき。

* [therubyracer](https://github.com/cowboyd/therubyracer) - メモリーを非常に多く使うので利用すべきではない。Node.js をインストールすべきである。
