## Framgia Git flow

Flow tham khảo: [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)

### Giả định
* Đã tạo Central Repository (Nguồn trung tâm) trên Github（hoặc Bitbucket）。
* Branch mặc định của Central Repository là master。
* Lập trình viên có thể  fork (tạo nhánh) đối với Central Repository。
* Đã quyết định người review và người có quyền merge。

### Nguyên tắc
* Mỗi pull-request tương ứng với một ticket và chỉ có một commit trong đó。
* Nội dung của commit là `refs [Loại ticket] #[Số ticket] [Nội dung ticket]` （Ví dụ: `refs bug #1234 Sửa lỗi cache`）。
* Tại môi trường local(trên máy lập trình viên), tuyệt đối không được thay đổi code khi ở branch master。Nhất định phải thao tác trên branch khởi tạo để làm task。

### Chuẩn bị

1. Trên Github (Bitbucket), fork Central Repository về tài khoản của mình（repository ở tài khoản của mình sẽ được gọi là Forked Repository）。

2. Clone (tạo bản sao) Forked Repository ở môi trường local。Tại thời điểm này, Forked Repository sẽ được tự động đăng ký dưới tên là `origin`。
    ```sh
    $ git clone [URL của Forked Repository]
    ```

3. Truy cập vào thư mục đã được tạo ra sau khi clone, đăng ký Central Repository dưới tên `upstream`。
    ```sh
    $ cd [thư mục được tạo ra]
    $ git remote add upstream [URL của Central Repository]
    ```

### Quy trình

Từ đây, Central Repository và Forked Repository sẽ được gọi lần lượt là `upstream` và `origin`。

1. Đồng bộ hóa branch master tại local với upstream。
    ```sh
    $ git checkout master
    $ git pull upstream master
    ```

2. Tạo branch để làm task từ branch master ở local. Tên branch là số ticket của task（Ví dụ: `task/1234`）。
    ```sh
    $ git checkout master # <--- Không cần thiết nếu đang ở trên branch master
    $ git checkout -b task/1234
    ```

3. Tiến hành làm task（Có thể commit bao nhiêu tùy ý）。

4. Trường hợp đã tạo nhiều commit trong quá trình làm task、tại 5. trước khi push phải dùng rebase -i để hợp các commit lại thành 1 commit duy nhất。
    ```sh
    $ git rebase -i [Giá trị hash của commit trước commit đầu tiên trong quá trình làm task]
    ```

5. Quay trở về branch master ở local và lấy code mới nhất về

    ```sh
    $ git checkout master
    $ git pull upstream master
    ```

6. Quay trở lại branch làm task, sau đó rebase với branch master。

    ```sh
    $ git checkout task/1234
    $ git rebase master
    ```
    **Trường hợp xảy ra conflict trong quá trình rebase、hãy thực hiện các thao tác của mục「Khi xảy ra conflict trong quá trình rebase」。**

7. Push code lên origin。

    ```sh
    $ git push origin task/1234
    ```

8. Tại origin trên Github（Bitbucket）、từ branch `task/1234` đã được push lên hãy gửi pull-request đối với branch master của upstream.

9. Hãy gửi link URL của trang pull-request cho reviewer trên chatwork để tiến hành review code。

    9.1. Trong trường hợp reviewer có yêu cầu sửa chữa, hãy thực hiện các bước 3. 〜 6.。

    9.2 push -f (push đè hoàn toàn lên code cũ) đối với remote branch làm task。
    ```sh
    $ git push origin task/1234 -f
    ```

    9.3 Tiếp tục gửi lại URL cho reviewer trên chatwork để tiến hành việc review code。

10. Nếu trên 2 người reviewer đồng ý với pull-request, người reviewer cuối cùng sẽ thực hiện việc merge pull-request。
11. Quay trở lại 1。

### Khi xảy ra conflict trong quá trình rebase

Khi xảy ra conflict trong quá trình rebase, sẽ có hiển thị như dưới đây (tại thời điểm này sẽ bị tự động chuyển về một branch vô danh)
```sh
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: refs #1234 Sửa lỗi cache
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging path/to/conflicting/file
CONFLICT (add/add): Merge conflict in path/to/conflicting/file
Failed to merge in the changes.
Patch failed at 0001 refs #1234 Sửa lỗi cache
The copy of the patch that failed is found in:
    /path/to/working/dir/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
```

1. Hãy thực hiện fix lỗi conflict thủ công（những phần được bao bởi <<< và >>> ）。
Trong trường hợp muốn dừng việc rebase lại, hãy dùng lệnh `git rebase --abort`。

2. Khi đã giải quyết được tất cả các conflict, tiếp tục thực hiện việc rebase bằng:

    ```sh
    $ git add .
    $ git rebase --continue
    ```
