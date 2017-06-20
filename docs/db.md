# Database

Như mọi ngôn ngữ lập trình, Elixir có thể sử dụng tất cả các database ngoài kia
từ PostgreSQL, MySQL đến NoSQL như MongoDB, ElasticSearch...

Nếu như Python có sẵn thư viện đi kèm cho SQLite3, thì Elixir không có gì.
Số thư viện built-in rất hạn chế của Elixir
https://hexdocs.pm/elixir/Kernel.html
dễ khiến ta lầm tưởng đây là ngôn ngữ mới, còn yếu chưa có gì...
Nhưng hãy nhớ rằng, Elixir được xây dựng trên Erlang, chạy trên nền máy ảo
BEAM, hệ thống đã có đầy đủ ecosystem hàng vài chục năm nay. Vậy nên mỗi khi
tìm kiếm gì, hãy nhớ dùng từ khoá Erlang thay vì chỉ tìm mỗi Elixir.
Erlang có database đi kèm ngôn ngữ: Mnesia /mˈniːzɪə/.
Một database đủ tốt để WhatsApp sử dụng cho [hệ thống chat phục vụ hàng tỷ
user](https://www.youtube.com/watch?v=c12cYAUTXXs). Tuy nhiên, nó có thể không
đủ tốt cho bạn, nhưng là một lựa chọn tốt để bắt đầu.

Tài liệu [Mnesia](https://github.com/h4cc/awesome-elixir)
cho Elixir không phải tìm cái là thấy ngay, ta search trong list
Awesome Elixir từ khoá "Mnesia" sẽ thấy [amnesia](https://github.com/meh/amnesia).
Tài liệu dẫn ta quay lại doc của [Mnesia cho
Erlang](http://erlang.org/doc/apps/mnesia/Mnesia_overview.html),
vì bản chất `amnesia` chỉ là một lớp code bọc (wrapper) để chuyển giữa Erlang
và Elixir mà thôi.

## Mnesia
Mnesia là một DBMS (Database Management Systems) - như MySQL, PostgreSQL, ...,
được viết riêng cho Erlang,
trên nền tảng Erlang, nhằm giải quyết vấn đề mà các DBMS khác mắc phải, đặc
biệt liên quan đến các hệ thống phân tán. Do Erlang/OTP hỗ trợ việc viết
các ứng dụng phân tán, nhu cầu đòi hỏi phải có 1 hệ thống DBMS cũng phân tán
được như nó, rõ ràng không có cách nào tốt hơn là xây dựng trên chính Erlang.
Hơn nữa, Mnesia được xây dựng riêng cho Erlang, nó dùng Erlang làm ngôn ngữ
để truy cập dữ liệu luôn, thay vì SQL. Điều này xoá đi vấn đề thông thường
khi làm việc với database: chuyển đổi kiểu dữ liệu giữa ngôn ngữ lập trình và
database (WHAO!).

## Cấu trúc của database
Một database là một tập hợp gồm các table (bảng), nó được lưu trên
máy tính trong một thư mục (folder/directory) được chỉ định.

### Database schema /ˈskiːmə/
http://erlang.org/doc/apps/mnesia/Mnesia_chap3.html#def_schema

Thông tin về tên các table, mỗi table được lưu trữ thế nào, ở đâu...

### Data model
Mỗi table thường đại diện cho một đối tượng (Nhân viên, học viên, hoá đơn...), nó bao gồm nhiều thuộc tính xếp thành các cột.

Mỗi "dữ liệu" sẽ được biểu diễn như 1 dòng của bảng. Trong Erlang/Elixir gọi là một record. Các record được biểu diễn thành kiểu dữ liệu tuple trong
Erlang/Elixir.

#### OID (Object Identifier)
Cặp giá trị (tuple-2) {Tablename, Key} dùng để xác định một record, được gọi là OID.

Ví dụ: một record của table student, khi biểu diễn bằng tuple ở dạng:

{}.. TODO là OID của record.

### Relation
Các DBMS thường thuộc loại RDBMS, R - relation.
Dữ liệu được lưu trữ trong MySQL, PostgreSQL là loại dữ liệu có quan hệ
với nhau. Một học viên có quan hệ với lớp mà học viên đó học (khoá học)...
một nhân viên có quan hệ với  phòng ban mà họ làm việc.

Mnesia tự nhận nó là ["extended relational"](http://erlang.org/doc/apps/mnesia/Mnesia_chap3.html#id66740), khi nó có khả năng lưu trữ bất kỳ
giá trị nào mà Erlang biểu diễn.

## Định nghĩa 1 database

## Tạo 1 database

## Ghi vào database


## Đọc từ database

https://www.amberbit.com/elixir-cocktails/elixir/using-mnesia-database-from-elisir/
