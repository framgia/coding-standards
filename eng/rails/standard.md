# Rules about writing Ruby on Rails code (Standard)

## Configurations

* Initializers of application are put in ``` config/initializers ```. Code written in here will be run when the application initializes.

* Code files used for gems configuration like ``` carrierwave.rb ``` or ``` active_admin.rb ``` should be named the same as gem name.

* Configurations for each environment such as development, test, production are put into corresponding files in ``` config/environments ``` folder.

* Configurations for all environments are written in ``` config/application.rb ```.

* In case of creating new environment like staging, try to configure it to be similar with production environment.

## Routing

* When adding more actions into RESTful resource, use ``` member ``` and ``` collection ```.

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

* Use block to group actions when there are many ``` member / collection ```.

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

* Use nested routes to represent models relation in ActiveRecord.

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

* Use namespace to group related actions.

```ruby
namespace :admin do
  # Directs /admin/products/* to Admin::ProductsController
  # (app/controllers/admin/products_controller.rb)
  resources :products
end
```

* Do not use wild controller route.

**Reason**

All actions of every controllers can be accessed by GET request.

```ruby
# really bad
match ':controller(/:action(/:id(.:format)))'
```

## Controller

* Try to shorten controller's code. In controller we should only get data for view, do not put business logic here (business logic should be in model).

* Ideal controller should include 1 initialize model method, 1 search method, 1 method to perform a task.

* Do not share more than 2 instance variables between controller and view.

* With instance variable to represent main resource in controller, assign object of resource to it. For example, with `@article` inside ArticlesController, assign it the instance of class `Article`. With `@articles`, assign it collection of class `Article`.

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

* Controller should handle exceptions from model. Announce exceptions by sending error code >= 400 to client.

* Parameter of render should be symbol.

```ruby
render :new
```

* Do not omit action even when that action doesn't perform any tasks and just being used for render view.

```ruby
class HomeController < ApplicationController

  def index
  end

end
```

* Actions which are accessed by other HTTP methods aside from GET, after finish processing, must be redirected to a action which is accessed by GET method. However, this is unnecessary for actions which are not accessed directly, such as calling API to return json.

**Reason**

Prevent extra processing when user refresh the browser.

* In callback, method name or ``` lambda ``` should be used. Do not use block.

```ruby
# bad

  before_action{@users = User.all} # block

# good

  before_action :methodname # method name

# also good

  before_action ->{@users = User.all} # lambda
```

## Model

* Model can be used without ActiveRecord.

* Try to name model short, easy to understand.

* Use gem [ActiveAttr](https://github.com/cgriego/active_attr) when need to have ActiveRecord's manipulations such as validations in model.

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

### ActiveRecord

* Must use existing database, do not change ActiveRecord defaults such as table name or primary key if there are no good reasons.

```ruby
# bad - do not do this if schema can be changed.
class Transaction < ActiveRecord::Base
  self.table_name = 'order'
  ...
end
```

* Group all macros together. Put constants of class on top. Macros of the same type (such as belongs_to or has_many) or same macro with different parameters (such as validates) should be arranged in alphabetical order. Callbacks should be ordered by call time.

* Macros should be ordered:
  * constants
  * attr_ macros
  * relation macros
  * validation macros
  * callback macros
  * other macros

#### Scope
* Scope should be named to represent getting a child collection from father collection.
* Scope should be named so it is easy to understand like this `[plural noun of model name] has characteristic [scope name]`. 
For example, with the scope named `active` in model `User` we can understand that getting `[users] has characteristice [active]`.
* With arguments, combine scope name with arguments so it is natural and easy to understand.
* Avoid naming scope including model name.

```ruby
# bad
class User < ActiveRecord::Base
  scope :active_users, ->{where activated: true}
end

class Post < ActiveRecord::Base
  scope :by_author, ->author{where author_id: author.id}
end

# good
class User < ActiveRecord::Base
  scope :active, ->{where activated: true}
end

class Post < ActiveRecord::Base
  scope :posted_by, ->author{where author_id: author.id}
end
```

* Scope should be written in short style like lambda. If there are more than 80 characters in a line, it should be cut to a new line so there are less than 80 characters in a line.

```ruby
class User < ActiveRecord::Base
  # constants on top
  GENDERS = %w(male female)

  # attr_ macros
  attr_accessor :formatted_date_of_birth

  attr_accessible :login, :first_name, :last_name, :email, :password

  # relation macros
  belongs_to :country

  has_many :authentications, dependent: :destroy

  # validation macros
  validates :email, presence: true
  validates :password, format: {with: /\A\S{8,128}\z/, allow_nil: true}
  validates :username, format: {with: /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/}
  validates :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}
  # in alphabetical order: email -> password -> username, format -> presence -> uniqueness

  # callback macros. in call time order: before -> after
  before_save :cook
  before_save :update_username_lower

  after_save :serve

  # scopes
  scope :active, ->{where(active: true)}

  # other macros (such as macros of devise)

  ...
end
```

* Do not use ``` default_scope ``` aside from delete logic related. Do not use ``` order ``` in this case.

* If use `has_many` or `has_one` in a model, must define `belongs_to` in the corresponding model.

## ActiveResource

* In case of returning response in format different from XML or JSON, you can define that format same as below. To create a new format you have to define 4 methods ``` extension ```、``` mime_type ```、``` encode ```、``` decode ```

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
          # Encode data to new format and return result
        end

        def decode(csv)
          # Decode data from new format and return result
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

* When request is sent without extension, we can override 2 methods ``` element_path ``` and ``` collection_path ``` of ``` ActiveResource::Base ```, then remove the extension part.

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

## Migration

=======
* Monitoring versions of ``` schema.rb ``` (or ``` structure.sql ```).

* Use ``` rake db:test:prepare ``` to create database for testing.

* If need to set default values, do not set them in application layer, set them in database layer by migrations.

```ruby
# bad - set default value in application layer
def amount
  self[:amount] or 0
end
```

Setting default values of colums in application layer only is a temporary solution, and may cause errors in application. Moreover, if the application shares the database with other applications, and the default values are set in application layer only, data consistency may not be ensured.

* Foreign keys are not supported by ActiveRecord but we can use 3rd party gem such as [schema_plus](https://github.com/lomba/schema_plus).

* To change the structure of tables, do not use ``` up ``` or ``` down ```, use ``` change ```.

```ruby
# bad, old style
class AddNameToPerson < ActiveRecord::Migration
  def up
    add_column :persons, :name, :string
  end

  def down
    remove_column :person, :name
  end
end

# good, new style
class AddNameToPerson < ActiveRecord::Migration
  def change
    add_column :persons, :name, :string
  end
end
```

* Do not use class of model in migration. Model class can be changed, so operations of old migrations might be affected.

## View

* Do not call model in view directly, call through controller or helper.

* Exception is calling model in view directly as a master for tags, such as `select` tag.

* Do not write complicate implementations in view, they should be in view helpers or models.

* Use partial or layout to avoid rewriting code.

* Use helper to write form. Code contains logic or configuration such as reading external files or link must be written using helper too.

* Do not use form_tag if usage of form_for is possible.

* Add 1 space inside ``` <% ``` , ``` <%= ``` and ``` %> ```.

```ruby
# bad
<%foo%>
<% bar%>
<%=bar%>
<%=bar %>

# good
<% foo %>
<%= bar %>
 ```


* Consider using [client side validation](https://github.com/bcardarella/client_side_validations). Usage as below
  * Define custom validator inherited from ``` ClientSideValidations::Middleware::Base ```

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

  * Create file ``` public/javascripts/rails.validations.custom.js.coffee ```、add reference to that file in ``` application.js.coffee ```.

```coffee
# app/assets/javascripts/application.js.coffee
#= require rails.validations.custom
```

  * Add validator of client.

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

## Multi languages

* Do not set configurations depended on languages, nations in model, controller, view. These configurations should be in ``` config/locales ```.

* When need to translate labels of ActiveRecord model, write under ``` activerecord ``` scope.

```yaml
ja:
  activerecord:
    models:
      user: メンバー
    attributes:
      user:
        name: 姓名
```

Therefore, ``` User.model_name.human ``` will return "メンバー", ``` User.human_attribute_name("name") ``` will return "姓名". This kind of translation can also be used in view.

* Separate translations of attributes of ActiveRecord and translations used in view into separated files. Files used for model should be in ``` models ``` folder, files used in view should be in ``` views ```.

  * Edit file ``` application.rb ``` to load files in locales folder when adding new files into it.

```ruby
# config/application.rb
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
```

* Put commonly used translations such as format of date time, currency in ``` locales ``` folder.

* Use short method names such as ``` I18n.t ``` instead of ``` I18n.translate ```, ``` I18n.l ``` instead of  ``` I18n.localize ```.

* Use lazy lookup in view. For example if we this structure:
```yaml
ja:
  users:
    show:
      title: "ユーザー情報"
```
then values of ``` users.show.title ``` in ``` app/views/users/show.html.haml ``` can be gotten by:
```ruby
= t '.title'
```

* In controller and model, do not use ``` :scope ```, instead we should use (.) to get the values we need. This is simpler and easier to understand.

```ruby
# use this
I18n.t 'activerecord.errors.messages.record_invalid'

# instead of this
I18n.t :record_invalid, :scope => [:activerecord, :errors, :messages]
```

* For more information [RailsGuide](http://guides.rubyonrails.org/i18n.html).

## Asset

Use asset pipeline

* Stylesheets, javascripts, or images of application are in ``` app/assets ```.

* Library files should be in ``` lib/assets ```. However library files which have been edited to be suitable for the application will not be put in here.

* Third party libraries such as jQuery or bootstrap are in ``` vendor/asstes ```.

* If possible, use gems of asset (for example：[jquery-rails](https://github.com/rails/jquery-rails)）。

* In CSS, use asset_url to write url.

## Mailer

* For mailer, name it like ``` SomethingMailer ```. This will be easier to know about the content of mail and which view it is related to.

* Write both HTML template and plain text template.

* In development environment, set it to return error when sending mail failed. The default setting is false.

```ruby
# config/environments/development.rb
config.action_mailer.raise_delivery_errors = true
```

* Must set host

```ruby
# config/environments/development.rb
config.action_mailer.default_url_options = {host: "localhost:3000"}

# config/environments/production.rb
config.action_mailer.default_url_options = {host: 'your_site.com'}

# in mailer class
default_url_options[:host] = 'your_site.com'
```

* When need to put links of application in mail, do not use ``` _path ``` method, use ``` _url ``` method. Because ``` _url ``` contains hostname but ``` _path ``` doesn't.

```ruby
# incorrect
You can always find more info about this course
= link_to 'here', url_for(course_path(@course))

# correct
You can always find more info about this course
= link_to 'here', url_for(course_url(@course))
```

* Define From and To correctly. Use below sample:

```ruby
# in mailer class
default from: 'Your Name <info@your_site.com>'
```

* With test environment, remember to set ``` test ``` for mail delivery method

```ruby
# config/environments/test.rb
config.action_mailer.delivery_method = :test
```

* With development environment or production environment, set ``` smtp ``` to be the mail delivery method

```ruby
# config/environments/development.rb, config/environments/production.rb
config.action_mailer.delivery_method = :smtp
```

* Because some mail clients may have errors with external CSS, when sending HTML mail, use inline CSS for all styles. It may be hard to maintain or duplicate code though. To solve those problems we can use [premailer-rails3](https://github.com/fphilipe/premailer-rails3) or [roadie](https://github.com/Mange/roadie).

* Avoid sending mail when page is being created. It may cause request timeout when too many mails are sent at the same time or the delay of page loading. To solve those problems we can use [delayed_job](https://github.com/tobi/delayed_job).

## Bundler

* Gems used only in development environment or test environment must be written in corresponding group.

* Only use necessary gems. Non-popular gems must be considered before using.

* For gems which depended on OS, when used in the other OSs Gemfile.lock file will be changed. Gems for OS X should be in ``` darwin ``` group, gems for Linux should be in ``` linus ``` group.

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

* To load suitable gems in correct environment, write as below in ``` config/application.rb ``` file

```ruby
platform = RUBY_PLATFORM.match(/(linux|darwin)/)[0].to_sym
Bundler.require(platform)
```

* Do not remove ``` Gemfile.lock ``` file from version management system. This file is for ensuring development environment of each developer uses the same gems versions when run ``` bundle install ```.
