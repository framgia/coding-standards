## Framgia Git flow

参考フロー: [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)

### 前提
* Github（または Bitbucket）上にセントラルリポジトリを作成済である。
* セントラルリポジトリのデフォルトブランチが master になっている。
* 各開発者が、セントラルリポジトリを Fork できる。
* レビュワーとマージ権限を持つ人が決まっている。

### 原則
* 1プルリクエストにつき、1チケットとする。
* 1プルリクエストでのコミット回数は自由。
* プルリクエストのタイトルをチケットのタイトルに合わせる。 `refs [チケットのトラッカー] #[チケット番号] [チケットのタイトル]` とする（例: `refs bug #1234 キャッシュが落ちない`）。\
  コミットのタイトルに関しては、プルリクに一つしかない場合はコミットタイトルを上記のプルリクエストのタイトル同じように`refs [チケットのトラッカー] #[チケット番号] [チケットのタイトル]` としても良い。（例: `refs bug #1234 キャッシュが落ちない`）。\
  複数のコミットがある場合はコミットタイトルはそのチケットでやるべきことのうち、何を対応したものか、を記載する必要があります。
    * 例：
        1. プルリクエストのタイトル：`refs bug #1234 キャッシュが落ちない`
        2. それに含まれるコミットのタイトルは下記のようになります。この場合は１プルリクエストに2コミットがあるとする。
            * `キャッシュをクリアするメソッドをモデルへ実装する`
            * `該当の controller のアクションでキャッシュをクリアするメソッドを呼ぶようにする`

* 2018/03/28以前存在していた、1プルリクエストにつき1コミットというルールは廃止。ただ、10人以上が稼動する大きなプロジェクト等、マージされた各ブランチを確認しやすくしたいケースではSquash and mergeを推奨。
* 2018/03/28以前存在していた、force pushは履歴を消すため非推奨。force pushをする際にはチームのコンセンサスを得てから行うこと。
* ローカルの master ブランチでコードを変更してはいけない。必ず作業ブランチ上で行うこと。

### 準備

1. Github（Bitbucket）上で、セントラルリポジトリを自分のアカウントに Fork する（この節では、Fork によって作成されたリポジトリを Forkedリポジトリ と呼ぶ）。

2. Forkedリポジトリをローカルに clone する。このとき、Forkedリポジトリが `origin` という名前で自動的に登録される。
    ```sh
    $ git clone [ForkedリポジトリのURL]
    ```

3. clone によって作成されたディレクトリに入り、セントラルリポジトリを `upstream` という名前で登録する。
    ```sh
    $ cd [作成されたディレクトリ]
    $ git remote add upstream [セントラルリポジトリのURL]
    ```

### 開発

以降、セントラルリポジトリ を `upstream`、 Forkedリポジトリを `origin` と呼ぶ。

1. ローカルの master ブランチを upstream の master ブランチと同期する。
    ```sh
    $ git checkout master
    $ git pull upstream master
    ```

2. ローカルで master ブランチから作業ブランチを作成する。ブランチ名はタスク番号（例: `task/1234`）などにする。
    ```sh
    $ git checkout master # <--- 既に master ブランチ上にいれば不要
    $ git checkout -b task/1234
    ```

3. 作業する。自由に commit して良い。そのcommitの内容を示すcommit messageをちゃんと書く。

4. origin に push する。

    ```sh
    $ git push origin task/1234
    ```

5. Github（Bitbucket）上で、origin に push済の `task/1234` ブランチから、upstream の `master` ブランチ に pull request を送る。

6. pull request の ページの URLをチャットワークに貼り、レビュワーにコードレビューを依頼する。

    6.1. レビュワーから修正依頼を出されたら、3. 〜 5. の作業を行う。

    6.2. 再度チャットワークに同じURLを貼り付け、レビューを依頼する。

7. 2人以上のレビュワーのOKが出たら、最後にOKを出したレビュワーがマージする。
8. 1に戻る。

### 1プルリクエストにつき1コミットの開発

以降、セントラルリポジトリ を `upstream`、 Forkedリポジトリを `origin` と呼ぶ。

1. ローカルの master ブランチを upstream の master ブランチと同期する。
    ```sh
    $ git checkout master
    $ git pull upstream master
    ```

2. ローカルで master ブランチから作業ブランチを作成する。ブランチ名はタスク番号（例: `task/1234`）などにする。
    ```sh
    $ git checkout master # <--- 既に master ブランチ上にいれば不要
    $ git checkout -b task/1234
    ```

3. 作業する（自由に commit して良い）。

4. 作業中に複数回 commit していたら、5.で push する前に rebase -i でコミットをひとつにまとめる。
    ```sh
    $ git rebase -i [作業内での最初のコミットよりひとつ前のハッシュ値]
    ```
   最初のコミットよりひとつ前のハッシュ値を指定するのは本質的な理由は
   master ブランチ以降のcommitを一つにまとめたいのでmasterと指定することで同様に実現できる。
   ```sh
   $ git rebase -i master
   ```
   コミットのタイトルは `refs [チケットのトラッカー] #[チケット番号] [チケットのタイトル]` とする（例: `refs bug #1234 キャッシュが落ちない`）。

5. ローカルの master ブランチに移動し、このブランチを最新にする
    ```sh
    $ git checkout master
    $ git pull upstream master
    ```

6. 作業ブランチに戻り、作業ブランチを master ブランチにリベースする。
    ```sh
    $ git checkout task/1234
    $ git rebase master
    ```
    **リベース中にコンフリクトのエラーが発生した場合には、後述の「リベース中にコンフリクトが発生したとき」の手順を実行する。**

7. origin に push する。

    ```sh
    $ git push origin task/1234
    ```

8. Github（Bitbucket）上で、origin に push済の `task/1234` ブランチから、upstream の `master` ブランチ に pull request を送る。

9. pull request の ページの URLをチャットワークに貼り、レビュワーにコードレビューを依頼する。

    9.1. レビュワーから修正依頼を出されたら、3. 〜 6. の作業を行う。

    9.2 同じリモートブランチに push -f （強制 push） する。
    ```sh
    $ git push origin task/1234 -f
    ```

    9.3 再度チャットワークに同じURLを貼り付け、レビューを依頼する。

10. 2人以上のレビュワーのOKが出たら、最後にOKを出したレビュワーがマージする。
11. 1に戻る。

#### リベース中にコンフリクトが発生したとき

リベース中にコンフリクトが発生すると、以下のように表示される（このとき、無名ブランチに自動的に移動している）。
```sh
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: refs #1234 キャッシュが落ちない
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging path/to/conflicting/file
CONFLICT (add/add): Merge conflict in path/to/conflicting/file
Failed to merge in the changes.
Patch failed at 0001 refs #1234 キャッシュが落ちない
The copy of the patch that failed is found in:
    /path/to/working/dir/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
```

1. 手動ですべてのコンフリクト（コード中で <<< と >>> に囲まれている部分）を解消する。
リベースを中止したいときには、`git rebase --abort` する。

2. すべてのコンフリクトを解消できたら、リベースを続行する。

    ```sh
    $ git add .
    $ git rebase --continue
    ```
