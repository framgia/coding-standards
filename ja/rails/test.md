#Ruby on Rails コーデング規約（テスト編）

新しい機能を実装するための一番良い方法はおそらく BDD であろう。一般に Cucumber が使われる、高水準の機能テストを書くことから始めて、機能実装をこのテストによって制御するのである。最初に機能に関するビューの仕様を書いて、それを元に関連するビューを実装する。その後にビューにデータを渡すコントローラーの仕様を作り、それを使ってコントローラーを実装する。最後にモデルの仕様を書いて、モデル自体を実装する、というように。

##Cucumber

* ペンディングしたシナリオは `@wip` (work in progress) タグを打っておくこと。そのシナリオは数に数えられず、失敗とも見なされない。ペンディングしたシナリオでテストしたいフィーチャーを実装して動かす時に、このシナリオがテストスイートに組み込まれるよう、 `@wip` タグを削除する。

* ` @javascript ` とタグ打ちされたシナリオが除外されるようにデフォルトプロファイルを設定しておくと良い。それらはブラウザーを使ってテストするもので、それを無効にすることで一般シナリオの実行速度を上げることが推奨されている。

* ` @javascript ` タグが付けられたシナリオのために個別のプロファイルを用意すると良い。
  * プロファイルは ` cucmber.yml ` ファイルで定義できる。

        ```Ruby
        # definition of a profile:
        profile_name: --tags @tag_name
        ```

  * プロファイルはこのようなコマンドを与えることで実行できる：

        ```
        cucumber -p profile_name
        ```

* link、button 等の文字を表示している要素があるかを確認するときは、エレメント ID ではなく文言を確認すること。そうすると i18n を利用しているときの問題を発見することができる。

* ある種類のオブジェクトにおいて、異なる機能であれば、フィーチャーを分けて作成する：

    ```Ruby
    # bad
    Feature: Articles
    # ... feature  implementation ...

    # good
    Feature: Article Editing
    # ... feature  implementation ...

    Feature: Article Publishing
    # ... feature  implementation ...

    Feature: Article Search
    # ... feature  implementation ...

    ```

* それぞれのフィーチャーは3つの主要な要素を持つ
  * タイトル
  * 文言 - このフィーチャーがどのようなものかの簡単な説明
  * 適合基準 - ステップの集合である、シナリオをさらに纏めたもの

* Connextra フォーマットが最も良く使われる。

    ```Ruby
    In order to [benefit] ...
    A [stakeholder]...
    Wants to [feature] ...
    ```

このフォーマットは最も良く使われているが、必須ではなく、文言はフィーチャーの複雑さによって自由に表現すればよい。

* シナリオを DRY に保つためにしなりとアウトラインを使うと良い。

    ```Ruby
    Scenario Outline: User cannot register with invalid e-mail
      When I try to register with an email "<email>"
      Then I should see the error message "<error>"

    Examples:
      |email         |error                 |
      |              |The e-mail is required|
      |invalid email |is not a valid e-mail |
    ```

* シナリオのステップは `step_definitions` ディレクトリ下の ` .rb ` ファイルに記述する。名前の規約は `[description]_steps.rb` とする。ステップは基準を作って別々のファイルに振り分けるようにする。`home_page_steps.rb` のように、それぞれのフィーチャーごとに1つのファイルに分けても良いし、 `articles_steps.rb` のように特定の対象に対して、全てのフィーチャーを1つのファイルに分けても良い。

* 繰り返しを避けるために、複数行にまとめた引数を用意する。

    ```Ruby
    Scenario: User profile
      Given I am logged in as a user "John Doe" with an e-mail "user@test.com"
      When I go to my profile
      Then I should see the following information:
        |First name|John         |
        |Last name |Doe          |
        |E-mail    |user@test.com|

    # the step:
    Then /^I should see the following information:$/ do |table|
      table.raw.each do |field, value|
        find_field(field).value.should =~ /#{value}/
      end
    end
    ```

* シナリオを DRY に保つために、複数のステップを纏めて使うようにする。

    ```Ruby
    # ...
    When I subscribe for news from the category "Technical News"
    # ...

    # the step:
    When /^I subscribe for news from the category "([^"]*)"$/ do |category|
      steps %Q{
        When I go to the news categories page
        And I select the category #{category}
        And I click the button "Subscribe for this category"
        And I confirm the subscription
      }
    end
    ```
* Capybara のマッチャーは ``` should_not ``` を肯定で使うのでは無く、否定のマッチャーを利用すること。そうすることで ajax のアクションで設定したタイムアウトの間、再試行するようになる。
[Capybara の README に、より詳しい説明がある。](https://github.com/jnicklas/capybara)

##RSpec

* 1つの example に期待結果を1つだけ書く。

   ```ruby
   # bad
   describe ArticlesController do
     describe "GET new" do
       before {get :new}
       it do
         assigns[:article].is_expected.to be_a_new Article
         response.is_expected.to render_template :new
       end
     end
   end

   # good
   describe ArticlesController do
     describe "GET new" do
       before {get :new}
       subject {response}
       it {is_expected.to render_template :new}
     end
   end
   ```

* `describe` と `context` は必要に応じて自由に使ってよい
  * `describe` はクラス、モジュール、メソッド（コントローラーのアクション等）ごとにグルーピングするのに使う。ビュー等の場合はこの規則に従わない。
  * `context` は example の条件をグルーピングするのに使う。

* `describe` のブロック名は下記のようにする
  * メソッド以外は説明を記載する
  * インスタンスメソッドの場合は "#method" のように "#" を使う
  * クラスメソッドの場合は ".method" のように "." を使う

  ```ruby
    class Article
      def summary
        #...
      end

      def self.latest
        #...
      end
    end

    # the spec...
    describe Article do
      describe "#summary" do
        #...
      end

      describe ".latest" do
        #...
      end
    end
  ```

* テスト用のオブジェクトを作成するときには [factory_girl](https://github.com/thoughtbot/factory_girl) を使う。
* モックやスタブは必要に応じて利用する
* モデルのモックを作るときには、`as_null_object` メソッドを使う。それを使うことで、期待するメッセージだけを出力することができ、他の全てのメッセージを無視することができる。

  ```ruby
    # mocking a model
    article = mock_model(Article).as_null_object

    # stubbing a method
    Article.stub(:find).with(article.id).and_return(article)
  ```

* example でデータを作成するときには、遅延評価にするために、`let` を使う。`let`の代わりにインスタンス変数を使うのは禁止とする。

  ```ruby
    # use this:
    let(:article) {FactoryGirl.create :article}

    # ... instead of this:
    before(:each) {@article = FactoryGirl.create :article}
  ```

* `expect` または `is_expected` を使うときには必ず `subject` を使う

  ```ruby
    describe Article do
      subject {FactoryGirl.create :article}
      it {is_expected.to be_published}
    end
  ```

* `it`の中では、`expect`または`is_expected`のみを使用して良い。`specify`や`should` を使ってはいけない。
* `it` の引数に文字列を設定してはいけない。自己説明的な spec を書くべき。

   ```ruby
   # bad
   describe Article do
     subject {FactoryGirl.create :article}
     it "is an Article" do
       subject.is_expected.to be_an Article
     end
end

   # good
   describe Article do
      subject {FactoryGirl.create :article}
      it {is_expected.to be_an Article}
   end
```
* `its` を使ってはいけない。

  ```ruby
    # bad
    describe Article do
      subject {FactoryGirl.create :article}
      its(:created_at) {is_expected.to eq Date.today}
    end

    # bad
    describe Article do
      subject {FactoryGirl.create :article}
      it {expect(subject.created_at).to eq Date.today}
    end
  ```

* `expect`の引数でのメソッドチェインは1回だけして良い。


* いくつかのテストで共有される spec グループを作りたいときには `shared_examples` を使う。

  ```ruby
    # bad
    describe Array do
      subject {Array.new [7, 2, 4]}
      context "initialized with 3 items" do
        it {expect(subject.size).to eq 3 }
      end
    end

    describe Set do
      subject {Set.new [7, 2, 4]}
      context "initialized with 3 items" do
        it {expect(subject.size).to eq 3}
      end
    end

    #good
    shared_examples "a collection" do
      subject {described_class.new([7, 2, 4])}
      context "initialized with 3 items" do
        it {expect(subject.size).to eq 3}
      end
    end

    describe Array do
      it_behaves_like "a collection"
    end

    describe Set do
      it_behaves_like "a collection"
    end
  ```

###Models
* 自分自身に対する spec の中で自分自身のモデルをモックにしてはいけない。
* モックで無いオブジェクトを作成するときには factory_girl を利用する。
* 自分以外のモデルや、子オブジェクトはモックにしても良い。
* factory されたモデルが valid であることを確認する example を作成すること。

  ```ruby
    describe Article do
      subject {FactoryGirl :article}
      it {is_expected.to be_valid}
    end
  ```

* validation が失敗することを確認するときに `.not_to be_valid`を使ってはいけない。validation を確認するときには、どの属性でエラーが発生したかを特定するために、 `have(x).errors_on` メソッドを使うこと。

  ```ruby
    # bad
    describe "#title" do
      subject {FactoryGirl.create :article}
      before {subject.title = nil}
      it {is_expected.not_to be_valid}
    end

    # prefered
    describe "#title" do
      subject {FactoryGirl.create :article}
      before {subject.title = nil}
      it {is_expected.to have(1).error_on(:title)}
    end
  ```

* validation する必要のある全ての属性それぞれについて個別に `describe` を追加する。
* モデルの属性がユニークであることをテストする時には、他のオブジェクトを `another_[object名]` という名前にする。

  ```ruby
    describe Article do
      describe "#title" do
        subject {FactoryGirl.build :article}
        before {@another_article = FactroyGirl.create :article}
        it {is_expected.to have(1).error_on(:title)}
      end
    end
  ```

###Views

* ビューの spec のディレクトリ `spec/views` の構造を`app/views` の構造と一致させる。例えば、`app/views/users` 内の各ディレクトリおよび各specが `spec/views/users` 内に配置されている各ディレクトリおよび各テンプレートファイルに対応するようにする。
* ビューの spec の命名規則については、ビュー名の最後に `_spec.rb` を付けることとする。例えば `_form.html.haml` に対応する spec は `_form.html.haml_spec.rb` とする。
* `spec_helper.rb` は様々な spec ファイルから必要とされるもののみを記述する。
* 最も外側の describe ブロックには `app/views` の部分を取り除いたビューのパスを指定する。これは引数を指定せずに `render` メソッドを呼んだときに使われる。

  ```ruby
    # spec/views/articles/new.html.haml_spec.rb
    require "spec_helper"

    describe "articles/new.html.haml" do
      # ...
    end
  ```

* ビューの spec 内で使うモデルには、常にモックを使う。ビューの役割は、あくまで情報を表示することである。
* 本来コントローラーによって設定されて、ビューで使われるようなインスタンス変数は、`assign` メソッドを使って設定する。

  ```ruby
    # spec/views/articles/edit.html.haml_spec.rb
    describe "articles/edit.html.haml" do
    subject {rendered}
    let(:article) {mock_model(Article).as_new_record.as_null_object}
    before do
      assign :article, article
      render
    end
    it do
      is_expected.to have_selector "form", method: "post", action: articles_path do |form|
        form.is_expected.to have_selector "input", type: "submit"
      end
    end
  ```

* Capybara の肯定表現を `.not_to` と組み合わせるのではなく、否定表現を `.to` と組み合せるようにする。

  ```ruby
    # bad
    page.is_expected.not_to have_selector "input", type: "submit"
    page.is_expected.not_to have_xpath "tr"

    # good
    page.is_expected.to have_no_selector "input", type: "submit"
    page.is_expected.to have_no_xpath "tr"
  ```

* ビューの spec でヘルパーメソッドを使うときには、それらを stub にしなければならない。ヘルパーメソッドは `template` オブジェクト上で stub にする。

  ```ruby
    # app/helpers/articles_helper.rb
    class ArticlesHelper
      def formatted_datei date
        # ...
      end
    end

    # app/views/articles/show.html.haml
    = "Published at: #{formatted_date @article.published_at}"

    # spec/views/articles/show.html.haml_spec.rb
    describe "articles/show.html.haml" do
      subject {rendered}
      before do
        article = mock_model Article, published_at: Date.new(2012, 01, 01)
        assign :article, article
        template.stub(:formatted_date).with(article.published_at).and_return("01.01.2012")
        render
      end
      it {is_expected.to have_content "Published at: 01.01.2012"}
    end
  ```

* ヘルパーの spec はビューの spec と分けて、`spec/helpers` ディレクトリに入れる。

###Controllers

* コントローラの spec 内でモデルクラスのインスタンスを扱う場合には mock を使用し、モデルが持つメソッドのふるまいは stub で定義する。コントローラーの spec の実行結果がモデルの実装に左右されてはいけないため。
* コントローラーが責任を持つべき、以下のふるまいのみをテストする。
  * 指定したメソッドが実行されているか
  * アクションから返るデータ、インスタンス変数にアサインされているか等
  * アクションの結果、正しくテンプレートを render しているか、リダイレクトしているか等

  ```ruby
    # Example of a commonly used controller spec
    # spec/controllers/articles_controller_spec.rb
    # We are interested only in the actions the controller should perform
    # So we are mocking the model creation and stubbing its methods
    # And we concentrate only on the things the controller should do

    describe ArticlesController do
      # The model will be used in the specs for all methods of the controller
      let(:article) {mock_model Article}
      let(:input) {"The New Article Title"}

      describe "POST create" do
        before do
          Article.stub(:new).and_return(article)
          article.stub(:save)
          post :create, message: {title: input}
        end

        it do
          expect(Article).to receive(:new).with(title: input).and_return article
        end

        it do
          expect(article).to receive(:save)
        end

        it do
          expect(response).to redirect_to(action: :index)
        end
      end
    end
  ```

* 受け取る params などによってコントローラーのアクションのふるまいが変化するときには context を利用する。

   ```ruby
   # A classic example for use of contexts in a controller spec is creation or update when the object saves successfully or not.

   describe ArticlesController do
      let(:article) {mock_model Article}
      let(:input) {"The New Article Title"}

      describe "POST create" do
        before do
          Article.stub(:new).and_return(article)
          post :create, article: {title: input}
        end

        it do
          expect(Article).to receive(:new).with(title: input).and_return(article)
        end

        it do
          expect(article).to receive :save
        end

        context "when the article saves successfully" do
          before do
           article.stub(:save).and_return(true)
          end

          it {expect(flash[:notice]).to eq("The article was saved successfully.")}
          it {expect(response).to redirect_to(action: "index")}
        end

        context "when the article fails to save" do
          before do
            article.stub(:save).and_return(false)
          end

          it {expect(assigns[:article]).to be article}
          it {expect(response).to render_template("new")}
        end
      end
   end
   ```

###Mailers

* メイラーの spec 内でのモデルは全て mock にする。メイラーがモデルに依存してはいけない。
* メイラーの spec は下記を確かめる。
  * 件名が正しいか
  * 受取人のメールアドレスが正しいか
  * 正しい送信者メールアドレスが設定されているか
  * メールが正しい情報を含んでいるか

  ```ruby
    describe SubscriberMailer do
      let(:subscriber) {mock_model(Subscription, email: "johndoe@test.com", name: "John Doe")}

      describe "successful registration email" do
        subject(:mail) {SubscriptionMailer.successful_registration_email(subscriber)}

        it {expect(mail.subject).to eq "Successful Registration!"}
        it {expect(mail.from).to eq ["info@your_site.com"]}
        it {expect(mail.to).to eq [subscriber.email]}
      end
    end
  ```
