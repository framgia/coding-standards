## Framgia Git flow

参考フロー: [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)

### 前提
* Github（または Bitbucket）上にセントラルリポジトリを作成済である。
* セントラルリポジトリのデフォルトブランチが develop になっている。
* 各開発者が、セントラルリポジトリを Fork できる。
* レビュワーとマージ権限を持つ人が決まっている。

### 原則
* 1プルリクエストにつき、1チケット 1コミット とする。
* コミットのタイトルは `refs #[チケット番号] [チケットのタイトル]` とする（例: `refs #1234 キャッシュが落ちない`）。
* ローカルの develop ブランチでコードを変更してはいけない。必ず作業ブランチ上で行うこと。

### 準備

1. Github（Bitbucket）上で、セントラルリポジトリを自分のアカウントに Fork する（この節では、Fork によって作成されたリポジトリを Forkedリポジトリ と呼ぶ）。

1. Forkedリポジトリをローカルに clone する。このとき、Forkedリポジトリが `origin` という名前で自動的に登録される。
    ```
    $ git clone [ForkedリポジトリのURL]
    ```

1. clone によって作成されたディレクトリに入り、セントラルリポジトリを `upstream` という名前で登録する。
    ```
    $ cd [作成されたディレクトリ]
    $ git remote add upstream [セントラルリポジトリのURL]
    ```

### 開発

以降、セントラルリポジトリ を `upstream`、 Forkedリポジトリを `origin` と呼ぶ。

1. ローカルの develop ブランチを upstream の develop ブランチと同期する。
    ```
    $ git checkout develop
    $ git pull upstream develop
    ```

1. ローカルで develop ブランチから作業ブランチを作成する。ブランチ名はタスク番号（例: `task/1234`）などにする。
    ```
    $ git checkout develop # <--- 既に develop ブランチ上にいれば不要
    $ git checkout -b task/1234
    ```

1. 作業する（自由に commit して良い）。

1. 作業中に複数回 commit していたら、5.で push する前に rebase -i でコミットをひとつにまとめる。
    ```
    $ git rebase -i [作業内での最初のコミットよりひとつ前のハッシュ値]
    ```

1. ローカルの develop ブランチに移動し、このブランチを最新にする

    ```
    $ git checkout develop
    $ git pull upstream develop
    ```

1. 作業ブランチに戻り、作業ブランチを develop ブランチにリベースする。

    ```
    $ git checkout task/1234
    $ git rebase develop
    ```
    **リベース中にコンフリクトのエラーが発生した場合には、後述の「リベース中にコンフリクトが発生したとき」の手順を実行する。**

1. origin に push する。

    ```
    $ git push origin task/1234
    ```

1. Github（Bitbucket）上で、origin に push済の `task/1234` ブランチから、upstream の `develop` ブランチ に pull request を送る。CIツールを使用するプロジェクトでは、このタイミングでテストが自動実行される。

1. pull request の ページの URLをチャットワークに貼り、レビュワーにコードレビューを依頼する。

    9.1. レビュワーから修正依頼を出されたら、3. 〜 6. の作業を行う。

    9.2 同じリモートブランチに push -f （強制 push） する。
    ```
    $ git push origin task/1234 -f
    ```

    9.3 再度チャットワークに同じURLを貼り付け、レビューを依頼する。

1. 2人以上のレビュワーのOKが出たら、最後にOKを出したレビュワーがマージする。
1. 1に戻る。

### リベース中にコンフリクトが発生したとき

リベース中にコンフリクトが発生すると、以下のように表示される（このとき、無名ブランチに自動的に移動している）。
```
$ git rebase develop
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

1. すべてのコンフリクトを解消できたら、リベースを続行する。

    ```
    $ git add .
    $ git rebase --continue
    ```

