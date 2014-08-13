#Các quy định về viết code Ruby on Rails (Phần viết test)

Phương pháp tốt nhất để cài đặt thêm một chức năng mới có lẽ là BDD. Thông thường thì hay sử dụng Cucumber, bắt đầu bằng việc viết test chức năng ở mức cao, sau đó điều chỉnh việc cài đặt (codding) chức năng theo đặc tả test. Đầu tiên sẽ viết các đặc tả của view liên quan đến chức năng, rồi cài đặt view liên quan dựa trên đặc tả này. Tiếp theo tạo đặc tả của controller để trao những data cần thiết cho các view ở trên, rồi cài đặt controler dựa trên các đặc tả này. Cuối cùng là viết các đặc tả cho model và cài đặt các model này.

##Cucumber

* Những scenario chưa hoàn thành thì gắn tag là  `@wip` (work in progress). Những scenario đó sẽ không được đếm và không hiện thị lỗi. Khi mà cài đặt và chạy các feature muốn test scenario này, có thể bỏ tag `@wip`.

* Có thể thiết lập profile mặc định để loại trừ các scenario có gắn tag ` @javascript `. Những cái đấy dùng để test khi dùng browser, thế nên thường được khuyên rằng nên vô hiệu hoá nó để tăng tốc độ chạy của các scenario thông thường khác.

* Có thể tạo profile riêng cho các scenario được gắn tag ` @javascript `.
  * Profile có thể định nghĩa tại file ` cucumber.yml `.

        ```Ruby
        # definition of a profile:
        profile_name: --tags @tag_name
        ```
  * Có thể chạy profile bằng lệnh sau:

        ```
        cucumber -p profile_name
        ```
* Khi kiểm tra sự tồn tại của các element có hiển thị text như link hay button thì không kiểm tra bằng ID mà kiểm tra bằng text. Vì làm như vậy sẽ có thể phát hiện ra lỗi trong trường hợp dùng i18n.

* Trong object nào đấy có nhiều chức năng khác thì nên chia các feature riêng:
    ```Ruby
    # Không tốt
    Feature: Articles
    # ... feature  implementation ...

    # Tốt
    Feature: Article Editing
    # ... feature  implementation ...

    Feature: Article Publishing
    # ... feature  implementation ...

    Feature: Article Search
    # ... feature  implementation ...

    ```

* Mỗi feature mang 3 yếu tố quan trọng
  * Tiêu đề
  * Miêu tả - giải thích ngắn gọn feature này là feature như thế nào
  * Quy chuẩn  - Tập hợp scenerio chứa các step

* Thường hay dùng format Connextra

    ```Ruby
    In order to [benefit] ...
    A [stakeholder]...
    Wants to [feature] ...
    ```

Format này hay được dùng nhưng không phải là bắt buộc, có thể miêu tả tự do tuỳ theo độ phức tạp của feature.

* Để đảm bảo tính DRY nên dung outline.

    ```Ruby
    Scenario Outline: User cannot register with invalid e-mail
      When I try to register with an email "<email>"
      Then I should see the error message "<error>"

    Examples:
      |email         |error                 |
      |              |The e-mail is required|
      |invalid email |is not a valid e-mail |
    ```

* Step của scenario thì được viết trong file ` .rb ` đặt tại thư mục `step_definitions`. Tên file đặt theo quy tắc `[description]_steps.rb`. Các step chia ra thành các file riêng biệt sử dụng kiểu chuẩn. Có thể chia theo kiểu từng feature 1 file riêng biệt giống như `home_page_steps.rb`. Hoặc cũng có thể chia theo đối tượng, và tất cả feature liên quan sẽ nằm trong 1 file giống như `articles_steps.rb`.

* Để tránh việc lặp lại thì chuẩn bị tham số đã được tập hợp trong nhiều dòng.

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

* Để đảm bảo tính DRY cho scenario nên tập hợp nhiều step để sử dụng.

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
* Matcher của Capybara không sử dụng ``` should_not ``` trong khẳng định mà dùng tại matcher phủ định. Vì vậy kịch bản sẽ được thực hiện lại  trong khoảng thời gian timeout của ajax action.
[Có thể tham khảo cụ thể tại README của Capybara.](https://github.com/jnicklas/capybara)

##RSpec

* Đối với 1 example thì chỉ nên kỳ vọng 1 kết quả đạt được.

   ```ruby
   # Cách viết không tốt
   describe ArticlesController do
     describe "GET new" do
       before {get :new}
       it do
         assigns[:article].is_expected.to be_a_new Article
         response.is_expected.to render_template :new
       end
     end
   end

   # Cách viết tốt
   describe ArticlesController do
     describe "GET new" do
       before {get :new}
       subject {response}
       it {is_expected.to render_template :new}
     end
   end
   ```

* Có thể sử dụng `describe` và `context` tự do khi cần thiết.
  * Sử dụng `describe` để nhóm theo class, module, method (hay theo action của controller). Trong trường hợp view thì không cần tuân theo quy tắc này.
  * Sử dụng `context` để nhóm các điều kiện của example.

* Đặt tên block của `describe` như sau
  * Viết giải thích cho trường hợp không là method.
  * Trong trường hợp đối với instance method thì gắn thêm "#" như "#method"
  * Trong trường hợp đối với class method thì gắn thêm "." như ".method"

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

* Sử dụng [factory_girl](https://github.com/thoughtbot/factory_girl) khi cần tạo các object phục vụ cho test.
* Sử dụng mock hoặc stub khi cần thiết.
* Khi tạo mock của model thì dùng method `as_null_object`. Khi chúng ta dùng method này thì có thể chỉ xuất ra những message kỳ vọng, tất cả các message khác sẽ được bỏ qua.

  ```ruby
    # mock một model
    article = mock_model(Article).as_null_object

    # stub một method
    Article.stub(:find).with(article.id).and_return(article)
  ```

* Khi tạo data trong example, sử dụng `let` để lazy evaluation. Cấm việc sử dụng biến instance để thay cho `let`.

  ```ruby
    # sứ dụng cách này
    let(:article) {FactoryGirl.create :article}

    # thay cho cách này
    before(:each) {@article = FactoryGirl.create :article}
  ```

* Khi sử dụng `expect` hoặc `is_expected` thì nhất định phải sử dụng `subject`.

  ```ruby
    describe Article do
      subject {FactoryGirl.create :article}
      it {is_expected.to be_published}
    end
  ```

* Ở bên trong `it` có thể sử dụng `expect` và `is_expected`. Không được sử dụng `specify` hoặc `should`.
* Không được lấy chuỗi kí tự là tham số của `it`. Nên viết spec dạng tự giải thích.

   ```ruby
   # Không tốt
   describe Article do
     subject {FactoryGirl.create :article}
     it "is an Article" do
       subject.is_expected.to be_an Article
     end
end

   # Tốt
   describe Article do
      subject {FactoryGirl.create :article}
      it {is_expected.to be_an Article}
   end
```
* Không được sử dụng `its`.

  ```ruby
    # Không tốt
    describe Article do
      subject {FactoryGirl.create :article}
      its(:created_at) {is_expected.to eq Date.today}
    end

    # Không tốt
    describe Article do
      subject {FactoryGirl.create :article}
      it {expect(subject.created_at).to eq Date.today}
    end
  ```

* Nên dùng method chain chỉ một lần với tham số của `expect`.


* Sử dụng `shared_examples` trong trường hợp muốn nhóm spec được chia sẻ tại nhiều test.

  ```ruby
    # Không tốt
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

    # Tốt
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
* Không mock chính bản thân mình trong spec model của mình.
* Sử dụng factory_girl khi tạo object không mock.
* Có thể mock các model khác, hoặc các object con.
* Tạo example để kiểm tra valid của model được factory.

  ```ruby
    describe Article do
      subject {FactoryGirl :article}
      it {is_expected.to be_valid}
    end
  ```

* Không sử dụng `.not_to be_valid` để kiểm tra xem validation có thất bại hay không. Để kiểm tra validation thì phải sử dụng method `have(x).errors_on` để xác định xem loại lỗi nào đã xảy ra.

  ```ruby
    # Không tốt
    describe "#title" do
      subject {FactoryGirl.create :article}
      before {subject.title = nil}
      it {is_expected.not_to be_valid}
    end

    # Tốt
    describe "#title" do
      subject {FactoryGirl.create :article}
      before {subject.title = nil}
      it {is_expected.to have(1).error_on(:title)}
    end
  ```

* Thêm `describe` riêng biệt cho các thuộc tính cần validation.
* Khi test xem loại của model có phải là unique hay không, dùng `another_[tên object]` để đặt tên cho các object khác.

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

* Đồng nhất cấu trúc thư mục spec của view `spec/views` với thư mục `app/views`. Ví dụ, các file spec của view trong thư mục `app/views/users` thì đặt trong thư mục tương ứng là `spec/views/users`.
* Về quy tắc đặt tên spec của view thì gắn thêm `_spec.rb` vào sau tên view. Ví dụ, spec tương ứng của `_form.html.haml` là `_form.html.haml_spec.rb`.
* Trong file `spec_helper.rb` chỉ viết những thứ cần thiết cho những spec khác.
* Đối với block describle ngoài cùng thì chỉ định path tới file view đã bỏ đi phần `app/views`. Cái này không phải là chỉ định tham số mà được sử dụng khi method `render` được gọi.

  ```ruby
    # spec/views/articles/new.html.haml_spec.rb
    require "spec_helper"

    describe "articles/new.html.haml" do
      # ...
    end
  ```

* Đối với các model trong spec của view thường thì dùng mock. Vài trò của view thì chỉ là để hiện thị.
* Sử dụng method `assign` để thiết lập các biến instance sử dụng trong view được thiết lập trong controller.

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

* Không kết hợp nội dung khẳng định của Capybara với `.not_to`, mà nên dùng `.to` với nội dung phủ định.

  ```ruby
    # Không tốt
    page.is_expected.not_to have_selector "input", type: "submit"
    page.is_expected.not_to have_xpath "tr"

    # Tốt
    page.is_expected.to have_no_selector "input", type: "submit"
    page.is_expected.to have_no_xpath "tr"
  ```

* Khi sử dụng helper method trong spec của view thì phải dùng stub. Stub helper method trên đối tượng `template`.

  ```ruby
    # app/helpers/articles_helper.rb
    class ArticlesHelper
      def formatted_date date
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

* Chia spec của helper và spec của view ra, đặt spec của helper trong `spec/helpers`.

###Controllers

* Trong spec của model nếu cần instance của class model thì dùng mock. Định nghĩa các method của model bằng stub. Nhằm không để kết quả chạy spec của controller ảnh hưởng đến việc cài đặt (implement) model.
* Controller nên có trách nhiệm, chỉ test những behavior dưới đây.
  * Những method chỉ đinh có được thực hiện không
  * Những data, biến instance được trả về từ action có được assign không
  * Kết quả của action là render chính xác template không, hay redirect chính xác hay không

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

* Khi mà behavior của action thay đổi thay đổi tuỳ theo params nhận được thì sử dụng context.

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

* Bên trong spec của mailer thì tất cả model đều mock. Mailer không phụ thuộc vào model.
* Trong spec của mailer tiến hành kiểm tra những điều sau.
  * Tiêu đề chính xác hay không
  * Địa chỉ mail của người nhận có chính xác không
  * Thiết lập địa chỉ mail người gửi chính xác không
  * Mail có chứa nội dung chính xác không

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