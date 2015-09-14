#Rules about writing Ruby on Rails code (test)

Best practice to add a new feature maybe BDD. Usually when use Cucumber, start with writing test in high level, then adjust code following test specification.
First write specification of views related to feature, then create related view following this specification.
Next write specification of controller to pass needed data to above views, then create controller following this specification.
Last write specification and create model.

##Cucumber

* Incompleted scenarios should be tagged `@wip` (work in progress). Those scenarios will not be counted and will not display error. When the feature is created and run, if you want to test these scenarios, you can remove tag `@wip`.

* Can setup default profile to exclude scenarios with tag ` @javascript `. Those are used for testing in browsers, so it is recommend to exclude them to speed up other scenarios.

* Can create a separate profile to for scenarios with tag ` @javascript `.
  * Profile can be defined in ` cucumber.yml ` file.

        ```Ruby
        # definition of a profile:
        profile_name: --tags @tag_name
        ```
  * Run profile by command:

        ```
        cucumber -p profile_name
        ```
* Check for existence of text elements such as link or button by checking for text, not by checking for ID. This will help finding errors with i18n.

* Object which has many features should be separated by features:
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

* Each feature has 3 important elements
  * Title
  * Description - short explanation about feature
  * Content - Collection of scenarios with steps

* Usually use Connextra format

    ```Ruby
    In order to [benefit] ...
    A [stakeholder]...
    Wants to [feature] ...
    ```

This format should be used but not enforced. You can freely describe feature depend on its complexity.

* Use outline to ensure DRY.

    ```Ruby
    Scenario Outline: User cannot register with invalid e-mail
      When I try to register with an email "<email>"
      Then I should see the error message "<error>"

    Examples:
      |email         |error                 |
      |              |The e-mail is required|
      |invalid email |is not a valid e-mail |
    ```

* Steps of each scenario is written in ` .rb ` files in `step_definitions` folder. File name follows format `[description]_steps.rb`.
We can separate steps into files using standard type. We can separate each feature into 1 file such as `home_page_steps.rb`, or separate based on object, and all related features will be in 1 file like `articles_steps.rb`.

* To avoid duplications, preparing arguments into multiple lines.

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

* To ensure DRY for scenarios, grouping multiple steps to use.

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
* Matcher of Capybara does not use ``` should_not ``` in positive but use in negative matcher. So scenarios will be executed in timeout of ajax action. [You can find more information in README of Capybara.](https://github.com/jnicklas/capybara)

##RSpec

* Expect only 1 result for 1 example

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

* Use `describe` and `context` freely when needed.
  * Use `describe` to group by class, module, method (or action of controller). You don't have to follow this rule with view.
  * Use `context` to group conditions of example.

* Name block of `describe` like the following
  * Write explanation in case of non-method.
  * In case of instance method add "#" like "#method"
  * In case of class method add "." like ".method"

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

* Use [factory_girl](https://github.com/thoughtbot/factory_girl) to create object for testing purpose.
* Use mock or stub if needed.
* When creating mock of model use `as_null_object` method. When we use this method, we can output expected messages only, all other messages will be ignored.

  ```ruby
    # mock of model
    article = mock_model(Article).as_null_object

    # stub of method
    Article.stub(:find).with(article.id).and_return(article)
  ```

* When create data for example, use `let` for lazy evaluation. Do not use instance variable instead of `let`.

  ```ruby
    # use this
    let(:article) {FactoryGirl.create :article}

    # instead of this
    before(:each) {@article = FactoryGirl.create :article}
  ```

* Must use `expect` or `is_expected` with `subject`.

  ```ruby
    describe Article do
      subject {FactoryGirl.create :article}
      it {is_expected.to be_published}
    end
  ```

* Inside `it` we can use `expect` and `is_expected`. Do not use `specify` or `should`.
* Do not use strings to be parameters of `it`. Write spec self explanatory.

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
* Do not use `its`.

  ```ruby
    # bad
    describe Article do
      subject {FactoryGirl.create :article}
      its(:created_at) {is_expected.to eq Date.today}
    end

    # good
    describe Article do
      subject {FactoryGirl.create :article}
      it {expect(subject.created_at).to eq Date.today}
    end
  ```

* Use method chain only once with argument of `expect`.

* Use `shared_examples` in case of grouping spec shared by multiple tests.

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

    # good
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
* Do not mock model in its own model spec.
* Use factory_girl to create object without mock.
* Can mock other models, or children objects.
* Create examples to check validity of model which has been `factoried`.

  ```ruby
    describe Article do
      subject {FactoryGirl :article}
      it {is_expected.to be_valid}
    end
  ```

* Do not use `.not_to be_valid` to check validation. Use `have(x).errors_on` method to identify which errors occur.

  ```ruby
    # bad
    describe "#title" do
      subject {FactoryGirl.create :article}
      before {subject.title = nil}
      it {is_expected.not_to be_valid}
    end

    # good
    describe "#title" do
      subject {FactoryGirl.create :article}
      before {subject.title = nil}
      it {is_expected.to have(1).error_on(:title)}
    end
  ```

* Add separate `describe` for attributes need to validate.
* When test for object is unique or not, use `another_[tên object]` to name the other objects.

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

* The structure of `spec/views` folder should be the same as `app/views` folder. For example, spec files of view in `app/views/users` folder will be in corresponding `spec/views/users` folder.
* Spec file naming rule is adding `_spec.rb` after view's name. For example, corresponding spec file of `_form.html.haml` is `_form.html.haml_spec.rb`.
* In `spec_helper.rb` only write necessary code for other specs.
* With the outermost `describe` block, defining path to view file should exclude the `app/views` part. This is not defining parameters but being used when calling `render` method.

  ```ruby
    # spec/views/articles/new.html.haml_spec.rb
    require "spec_helper"

    describe "articles/new.html.haml" do
      # ...
    end
  ```

* Models in spec of view are usually created by mock. View is for presentation purpose only.
* Use `assign` method to define instance variables used in view which are defined in controller.

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

* Do not combine positive declaration of Capybara with `.not_to`, use `.to` with negative declaration.

  ```ruby
    # bad
    page.is_expected.not_to have_selector "input", type: "submit"
    page.is_expected.not_to have_xpath "tr"

    # good
    page.is_expected.to have_no_selector "input", type: "submit"
    page.is_expected.to have_no_xpath "tr"
  ```

* Use stub for helper method in spec of view. Stub helper method on `template` object.

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

* Put spec of helper in `spec/helpers`.

###Controllers

* Use mock for instance of model class. Use stub for model's methods. This is to avoid results of controller spec affecting implementation of model.
* Controller should only test below behaviors
  * If methods are executed or not.
  * Data, instance variables returned from action are assigned or not.
  * Result of action: render correct template or not, redirect correctly or not.

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

* If behavior of action changes based on parameters, use context.

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

* Inside spec for mailer, all models should be mocked. Mailer does not depend on model.
* In spec of mailer, test for the below behaviors
  * Title is correct or not
  * Recipient is correct or not
  * Sender is correct or not
  * Mail content is correct or not

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
