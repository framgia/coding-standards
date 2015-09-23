#List of standardized gems in Ruby on Rails

One of the principles of software development is DRY - Don't Repeat Yourself.
When facing with a problem, before trying to solve it by yourself, first researching if there are any existing solutions.
Below is a list of valuable gems which have proved to be useful in many Rails projects.
All gems work with Rails 3.1.

##Creating admin panel

* [active_admin](https://github.com/gregbell/active_admin) - Help creating admin panel in a simple way. It can quickly create CRUD functions of models and give a flexible customization.

##Development environment, test environment improvement

**These are not suitable for production environment**

* [capybara](https://github.com/jnicklas/capybara) - Easily implement integration test for web frameworks using Rack such as Rails, Sinatra, Merb. Help simulating users' interactions with web application. Built-in support for Rack::Test and Selenium. Using of HtmlUnit, Webkit, env.js can be done by installing extra gems. RSpec and Cucumber can be used simultaneously is also a plus.

* [better_errors](https://github.com/charliesome/better_errors) - Replace Rails default error pages with a more convenient error pages. It can also be used as Rack Middleware in other Rack applications outside of Rails.

* [cucumber-rails](https://github.com/cucumber/cucumber-rails) - A helpful tool to implement integration test in Rails. Using it allow us to use Cucumber in Rails.

* [factory_girl](https://github.com/thoughtbot/factory_girl) - Help creating objects for test actions.

* [ffaker](https://github.com/EmmanuelOga/ffaker) - Help creating sample data easily.

* [guard](https://github.com/guard/guard) - Can monitoring changes made to files and do automated tasks. Used in many tools.

* [spork](https://github.com/sporkrb/spork) - A DRb server for testing frameworks such as RSpec or Cucumber. By pre-populating test environment, it helps shorten time spent on testing.

* [simplecov](https://github.com/colszowka/simplecov) - Analyze overall information about code. Can be used with Ruby 1.9.

* [rspec-rails](https://github.com/rspec/rspec-rails) - For using RSpec in Rails.

##Performance improvement

* [bullet](https://github.com/flyerhzm/bullet) - Improve performance of application by reducing number of queries. It monitors your queries and notify you where you should add eager loading (n + 1 queries), where eager loading is unnecessary or where you should use counter cache.

##Upload file

* [Paperclip](https://github.com/thoughtbot/paperclip) - File attachment library that works with ActiveRecord.

##Search

* [sunspot](https://github.com/sunspot/sunspot) - A library for using Solr search engine.

##Authorization management

* [cancan](https://github.com/ryanb/cancan) - Can restrict users' access to resources. All authorities are managed in one place and can be checked across the application.

* [devise](https://github.com/plataformatec/devise) - Give you all necessary features for an application.

##View template

* [haml-rails](https://github.com/indirect/haml-rails) - Help using HAML in Rails.

* [haml](http://haml-lang.com) - HAML is a shorter template language than ERB.

* [slim](http://slim-lang.com) - Slim is considered better than ERB and HAML. Slim also has good performance. The main reason for not using Slim is it isn't widely supported by many editors or IDE.

##Client side support

* [client_side_validations](https://github.com/bcardarella/client_side_validations) - Automatically create Javascript validations which run on client side based on validations defined in models in server.

##SEO

* [friendly_id](https://github.com/norman/friendly_id) - Help identify objects by friendly-reading attributes instead of id of models.

##Pagination

* [kaminari](https://github.com/amatsuda/kaminari) - For flexible pagination.

##Image manipulation

* [minimagick](https://github.com/probablycorey/mini_magick) - Ruby wrapper of ImageMagick

##These gems should be standard or not is undecided

* [simplecov-rcov](https://github.com/fguillen/simplecov-rcov) - RCov format for SimpleCov. Useful for using SimpleCov with Hudson continuous integration server.

* [carrierwave](https://github.com/jnicklas/carrierwave) - Help with uploading files in Rails. Support local storage and cloud storage for uploaded files (and many other features). Integrated with ImageMagick helps us with image manipulation.

* [compass-rails](https://github.com/chriseppstein/compass) - Support for some css frameworks. Include collections of sass mixin which helps shorten css code and dealt with incompatible browsers.

* [fabrication](http://fabricationgem.org/) - A good replacement for fixtures.

* [feedzirra](https://github.com/pauldix/feedzirra) - Analyze RSS/Atom faster and easier.

* [globalize3](https://github.com/svenfuchs/globalize3.git) - Globalize3 is the next version of Globalize in Rails, target ActiveRecord version 3.x. It is compatible and is built on top of the new I18n API of Ruby on Rails and add translations into ActiveRecord.

* [machinist](https://github.com/notahat/machinist) - Easily create objects for testing purposes.

* [simple_form](https://github.com/plataformatec/simple_form) - Once you use simple form, you will never want to use Rails default forms again. It has good DSL for creating forms and no options on markup.

* [email-spec](https://github.com/bmabey/email-spec) - Easily testing email with RSpec and Cucumber.

##Gems which are not recommended

These gems have errors or there are better gems. You shouldn't use these if possible.

* [rmagick](http://rmagick.rubyforge.org/) - We shouldn't use this because it uses memory wastefully. Use minimagick instead.

* [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/) - An automation test tool. Use guard instead.

* [rcov](https://github.com/relevance/rcov) - Does not support Ruby 1.9. Use simplecov instead.

* [therubyracer](https://github.com/cowboyd/therubyracer) - It uses too much memory. Use Node.js instead.
