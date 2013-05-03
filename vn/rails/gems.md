#Danh sách các gem kiểu chuẩn trong Ruby on Rails

Một trong những nguyên tắc quan trọng nhất khi lập trình đó là "Don't Repeat Yourself!". Khi phải đối mặt với vấn đề gì đấy thì trước khi bản thân giải quết vấn đề đó cần phải tìm hiểu xem tồn tại những cách giải quyết nào. Dưới đây là danh sách những gem rất có giá trị, những cái có ích trong rất nhiều dự án Rails. Tất cả đều hoạt động đối với Rails 3.1.

##Việc tạo màn hình quản lý

* [active_admin](https://github.com/gregbell/active_admin) - Giúp tạo màn hình quản lý một cách đơn giản. Ngoài ra cũng có thể nhanh chóng tạo ra các xử lý CRUD của các model và có thể tuỳ chỉnh một cách linh hoạt.

##Môi trường phát triển, cải thiện môi trường test

**Chú ý: điều này không phù hợp vớ môi trường production**

* [capybara](https://github.com/jnicklas/capybara) - Là gem giúp cho dễ dàng thực hiện integration test trong các web framework mà là ứng dụng Rack như Rails, Sinatra hay Merb. Giúp mô phỏng các thao tác của người dùng thực tế trong ứng dụng web. Hỗ trợ Rack::Test và Selenium được cài đặt sẵn. Có thể sử dụng HtmlUnit, Webkit, env.js bằng việc cài thêm gem. Việc có thể sử dụng đồng thời RSpec và Cucumber là rất có lợi.

* [better_errors](https://github.com/charliesome/better_errors) - Là gem giúp thay thế trang thông báo lỗi kiểu chuẩn bằng một kiểu tiện lợi hơn. Ngoài ra có thể sử dụng như là Rack middleware trong các ứng dụng Rack khác ngoài Rails.

* [cucumber-rails](https://github.com/cucumber/cucumber-rails) - Là công cụ rất tốt để thực hiện integration test trong Ruby. Việc sử dụng cucumber-rails sẽ giúp chúng ta có thể dùng Cucumber trong Rails.

* [factory_girl](https://github.com/thoughtbot/factory_girl) - Giúp tạo các object phục vụ cho các nhiệm vụ như test chẳng hạn.

* [ffaker](https://github.com/EmmanuelOga/ffaker) - Giúp tạo dữ liệu mẫu một cách đơn giản.

* [guard](https://github.com/guard/guard) - Có thể theo dõi sự thay đổi của file và tự động thực hiện các nhiệm vụ. Được sử dụng trong rất nhiều cộng cụ.

* [spork](https://github.com/sporkrb/spork) - Một DRb server cho testing framework như RSpec hay Cucumber, sẽ giúp chuẩn bị để có thể test trong điều kiện tốt. Bằng việc load trước môi trường test nên giúp rút ngắn khá nhiều thời gian test.

* [simplecov](https://github.com/colszowka/simplecov) - Công cụ phân tích thông tin bao quát về code và có thể dùng với Ruby 1.9.

* [rspec-rails](https://github.com/rspec/rspec-rails) - Giúp cho dễ dàng sử dụng RSpec trong Rails.

##Cải thiện hiệu năng

* [bullet](https://github.com/flyerhzm/bullet) - Được thiết kế để giúp tăng hiệu năng của ứng dụng bằng việc giảm số query. Nó sẽ theo dõi nhưng câu query của bạn trong quá trình phát triển và chỉ ra nơi nên thêm eager loading (N+1 queries), hoặc nơi không cần thiết eager loading hoặc nên sử dụng counter cache.

##Upload file

* [Paperclip](https://github.com/thoughtbot/paperclip) - Có thể đính file trong ActiveRecord.

##Tìm kiếm text

* [sunspot](https://github.com/sunspot/sunspot) - Hệ thống tìm kiếm text sử dụng SOLR.

##Quản lý phân quyền

* [cancan](https://github.com/ryanb/cancan) - Có thể giới hạn khả năng truy cập tài nguyên của người dùng. Tất cả quyền hạn thì được quản lý trong một file và có thể xác thực trên toàn ứng dụng.

* [devise](https://github.com/plataformatec/devise) - Hầu như đã chuẩn bị sẵn hết tất cả chức năng cần thiết.

##View template

* [haml-rails](https://github.com/indirect/haml-rails) - Giúp có thể sử dụng HAML trong Rails.

* [haml](http://haml-lang.com) - HAML được xem là ngôn ngữ template ngắn gọn hơn ERB.

* [slim](http://slim-lang.com) - Slim không chỉ hơn ERB mà còn được cho rằng tốt hơn cả HAML. Lý do ngần ngại sử dụng Slim có chăng chỉ là chưa được hỗ trợ bởi nhiều editor hay IDE. Ngoài ra, hiệu năng của Slim khá là tốt.

##Hỗ trợ phía client

* [client_side_validations](https://github.com/bcardarella/client_side_validations) - Tự động tạo ra validation của Javascript chạy trên client dựa trên các validation của các model định nghĩa tại server.

##SEO

* [friendly_id](https://github.com/norman/friendly_id) - Giúp có thể chỉ định các object thông qua các thuộc tính được miêu tả dễ hiểu thay cho id của model.

##Phân trang

* [kaminari](https://github.com/amatsuda/kaminari) - giúp phân trang một cách linh hoạt.

##Chỉnh sửa ảnh

* [minimagick](https://github.com/probablycorey/mini_magick) - Ruby wrapper của ImageMagick

##（Chưa quết định xem có là gem kiểu chuẩn không）

* [simplecov-rcov](https://github.com/fguillen/simplecov-rcov) - Định dạng theo kiểu RCov cho SimpleCov. Hữu ích khi muốn sử dụng SimpleCov với Hudson continious integation server.

* [carrierwave](https://github.com/jnicklas/carrierwave) - Giúp việc upload file đơn giản hơn trong Rails. Hỗ trợ cả lưu trữ local và cloud cho những file được upload ( và nhiều cái thú vị khác nữa). Ngoài ra nó còn tích hợp với ImageMagick giúp cho chúng ta có thể thêm các xử lý file ảnh.

* [compass-rails](https://github.com/chriseppstein/compass) - Là gem khá tốt, nó thêm hỗ trợ cho một vài css framework. Bao gồm tập các sass mixin giúp rút ngắn code css và giúp xử lý việc không tương thích trình duyệt.

* [fabrication](http://fabricationgem.org/) - Một trong những cái thay thế tốt cho fixtures.

* [feedzirra](https://github.com/pauldix/feedzirra) - Giúp phân tích RSS/Atom khá nhanh và tiện lợi.

* [globalize3](https://github.com/svenfuchs/globalize3.git) - Globalize3 là bản kế tiếp của Globalize trong Rails và nhắm tới ActiveRecord phiên bản 3.x. Nó tương thích và được xây dựng trên API I18n mới của Ruby on Rails và có thêm bộ dịch vào ActiveRecord.

* [machinist](https://github.com/notahat/machinist) - Giúp dễ dàng tạo các object phục vụ cho test.

* [simple_form](https://github.com/plataformatec/simple_form) - Một khi mà đã dùng simple_form thì sẽ không bao giờ muốn nghe đến form mặc định của Rails.
. Nó có DSL khá tốt cho việc tạo form và không cần quan tâm đến markup.

* [email-spec](https://github.com/bmabey/email-spec) - Dễ dàng thực hiện test email bằng RSpec hoặc Cucumber.

##Những gem không khuyến khích dùng

Những gem này vần có lỗi hoặc là có những gem tốt hơn. Tốt nhất nên tránh dùng những gem này.

* [rmagick](http://rmagick.rubyforge.org/) - Nên tránh dùng bởi vì nó sử dụng bộ nhớ một cách lãng phí. Thay vào đó ta nên dùng minimagick.

* [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/) - Công cụ test tự động. Nên dùng một gem tốt hơn đó là guard.

* [rcov](https://github.com/relevance/rcov) - Không hỗ trợ Ruby 1.9. Thay vào đó ta nên dùng simplecov.

* [therubyracer](https://github.com/cowboyd/therubyracer) - Không nên dùng vì nó dùng quá nhiều bộ nhớ. Chúng ta có thể cài đặt Node.js.
