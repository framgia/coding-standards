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

* シナリオのステップは `step_definitions` ディレクトリ下の ` .rb ` ファイルに記述する。名前の規約は `[description]_steps.rb` とする。ステップは基準を作って別々のファイルに振り分けるようにする。`home_page_steps.rb` のように、それぞれのごとフィーチャーに1つのファイルに分けても良いし、 `articles_steps.rb` のように特定の対象に対して、全てのフィーチャーを1つのファイルに分けても良い。

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
* Cpybara のマッチャーは ``` should_not ``` を肯定で使うのでは無く、否定のマッチャーを利用すること。そうすることで ajax のアクションで設定したタイムアウトの間、再試行するようになる。
[Capybara の README により詳しい説明がある。](https://github.com/jnicklas/capybara)

