# Học Elixir trong một giấc mơ
[BETA]

Lý do bạn thích học Haskell, LISP, Erlang, Elixir, Ocaml, Scala... những ngôn ngữ lập trình hàm (functional programming language) có vẻ hay ho, mà không bao giờ thành công là gì?

Sau đây là vài lý do mình gặp phải:

- Quá nhiều khái niệm mới
- Nhồi nhét hết các khái niệm xong không có gì để làm
- Chọn ngôn ngữ "xịn" nhất: trong mảnh đất functional programming, rất nhiều cái tên hấp dẫn khác như Haskell, Ocaml, Racket, Scheme, CLisp, Scala,...

Để khắc phục điều này, ta sẽ:

- Chỉ tập trung vào những khái niệm đã quen thuộc, học thật nhanh, tra cứu khi cần
- Có một ý tưởng để thực hiện
- Tập trung vào Elixir vì mỗi ngôn ngữ đều có điểm mạnh/ yếu riêng, nhưng khi nắm được một ngôn ngữ, học các ngôn ngữ khác sẽ trở nên dễ dàng hơn nhiều do đã quen thuộc các khái  niệm và lối tư duy của functional programming.


Nếu không có gì để làm, nuốt xong các khái niệm, 1 tuần sau bạn sẽ lại quên.

Elixir/Erlang hoàn toàn đủ khả năng để cho bạn lập trình loanh quanh mấy thuật toán, giải các bài toán / vấn đề trên HackerRank. Nhưng điểm sáng của ngôn ngữ này, thực ra chỉ toả sáng khi ta dùng nó để phát triển các hệ thống lớn, cần chạy phân tán, hay chạy song song... Ít khi một người sẽ làm hẳn một project lớn như vậy. Vì vậy, ta thường không có đất dùng cho Elixir hay Erlang.

Một cách ứng dụng để chơi với ngôn ngữ mới nữa "nhỏ hơn", là viết các câu lệnh thực hiện một việc gì đó (CLI). Vậy nhưng Elixir/Erlang không toả sáng/ đơn giản trong công việc này, nó CÓ THỂ làm được, nhưng trên thực tế không mấy ai làm.

Ví dụ standard khi học Erlang là làm một hệ thống chat. Trên thực tế, hệ thống chat của "Whatsapp" được viết bằng Erlang [hệ thống này đã được bán lại cho FaceBook với giá 19 TỶ đô la Mỹ](http://highscalability.com/blog/2014/2/26/the-whatsapp-architecture-facebook-bought-for-19-billion.html) (PS: FaceBook trước đó cũng đã mua lại Instagram - một hệ thống viết bằng Django/Python với giá 1 TỶ đô la Mỹ)

Ta có thể làm 1 website sau khi học Elixir, đây là lĩnh vực hiện tại mà Elixir mạnh nhất.

Đã xong phần ý tưởng, bây giờ hãy học Elixir.

Thực hiện trên:

```
$ elixir --version
Erlang/OTP 19 [erts-8.0.2] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Elixir 1.3.2
```

PS: trong bài có một số đoạn so sánh với tính năng tương tự trên Python - bởi tác giả là người có kinh nghiệm với Python - giúp các lập trình viên Python dễ kết nối các khái niệm. Phần so sánh này hoàn toàn không cần thiết với người không biết Python và có thể bỏ qua.

## Các kiểu dữ liệu cơ bản

### Integer

```
iex(33)> 42
42
iex(34)> i 42
Term
  42
Data type
  Integer
Reference modules
  Integer

Dùng ``i OBJECT`` để hiển thị thông tin về giá trị/ kiểu của object. Như "type(object)" trong Python hay "typeof object" trong JavaScript.
```

### Float

```
iex(35)> i 3.14
Term
  3.14
Data type
  Float
Reference modules
  Float

iex(36)> 0.1 + 0.1 + 0.1
0.30000000000000004
```

### Atom

```
iex(39)> i true
Term
  true
Data type
  Atom
Reference modules
  Atom
iex(40)> i false
Term
  false
Data type
  Atom
Reference modules
  Atom
```

### String

```
iex(42)> i "Elixir"
Term
  "Elixir"
Data type
  BitString
Byte size
  6
Description
  This is a string: a UTF-8 encoded binary. It's printed surrounded by
  "double quotes" because all UTF-8 encoded codepoints in it are printable.
Raw representation
  <<69, 108, 105, 120, 105, 114>>
Reference modules
  String, :binary
```

Các kiểu dữ liệu chứa được kiểu khác: list, tuple, dict

### List

```
iex(44)> i 'abc'
Term
  'abc'
Data type
  List
Description
  This is a list of integers that is printed as a sequence of characters
  delimited by single quotes because all the integers in it represent valid
  ASCII characters. Conventionally, such lists of integers are referred to as
  "charlists" (more precisely, a charlist is a list of Unicode codepoints,
  and ASCII is a subset of Unicode).
Raw representation
  [97, 98, 99]
Reference modules
  List


iex(45)> i [1,2,3,3.14]
Term
  [1, 2, 3, 3.14]
Data type
  List
Reference modules
  List

iex(46)> i []
Term
  []
Data type
  List
Reference modules
  List
```

Một list có thể chứa bất kỳ kiểu dữ liệu nào:

```
iex(6)> i ["abc", 1]
Term
  ["abc", 1]
Data type
  List
Reference modules
  List
```

Với list chứa các phần tử tuple-2 {atom: value}, Elixir hỗ trợ thêm cú pháp ngắn gọn để tạo ra list này và gọi là "keyword list" (bản chất vẫn là 1 list bình thường):

```
iex(38)> [{:name, "PyMi"}, {:est, 2015}]
[name: "PyMi", est: 2015]
iex(39)> [name: "PyMi", est: 2015]
[name: "PyMi", est: 2015]

iex(38)> [{:name, "PyMi"}, {:est, 2015}]
[name: "PyMi", est: 2015]
iex(39)> [name: "PyMi", est: 2015]
[name: "PyMi", est: 2015]

```

Có thể truy cập phần tử của keyword list bằng key, khi nhiều key trùng nhau,
truy cập sẽ trả về giá trị đầu tiên ứng với key.
```
iex(16)> [foo: "pika", foo: "pikachu"]
[foo: "pika", foo: "pikachu"]
iex(17)> [foo: "pika", foo: "pikachu"][:foo]
"pika"
```

### Tuple

```
iex(48)> i {100, 'abc'}
Term
  {100, 'abc'}
Data type
  Tuple
Reference modules
  Tuple
iex(49)> i {}
Term
  {}
Data type
  Tuple
Reference modules
  Tuple

```

Không giống Python, trong Elixir, TẤT CẢ các kiểu dữ liệu đều là immutable, tức một khi đã tạo ra, không thể thay đổi. Muốn "thay đổi", ta phải tạo mới.

Trên Python, những điều sau đều có thể làm trên list hay tuple:
- duyệt qua từng phần tử (loop)
- truy cập index
- slice để thu được một tập con

Sự giống nhau về tính năng khiến người dùng thường hỏi khi nào dùng list, khi nào dùng tuple.
Với Python, ta có thể thay đổi 1 list, nhưng không thể thay đổi một tuple sau khi đã tạo ra nó.
Với Elixir, cả list và tuple đều không thể thay đổi được (immutable).
Đặc điểm này sẽ giúp thấy rõ hơn khi nào dùng tuple và khi nào nên dùng list:
- list THƯỜNG dùng để chứa các dữ liệu tương tự nhau (heterogenious)
- tuple thường để chứa các thông tin liên quan đến nhau, như các cột trong 1 dòng của database, các toạ độ của một điểm, các đặc tính của một con mèo...

Khi đó, ta sẽ thường loop qua 1 list, và thường truy cập đến các phần tử của tuple thông qua indexing/unpacking.

```
iex(52)> person = {"HVN", 27, "Python"}
{"HVN", 27, "Python"}
iex(53)> {name, age, language} = person
{"HVN", 27, "Python"}
iex(54)> name
"HVN"
```

http://elixir-lang.org/getting-started/basic-types.html#lists-or-tuples
http://stackoverflow.com/questions/31192923/lists-vs-tuples-what-to-use-and-when

### Map (dictionary)

```
iex(51)> i %{"name": "FAMILUG"}
Term
  %{name: "FAMILUG"}
Data type
  Map
Reference modules
  Map
```

### MapSet - kiểu dữ liệu tập hợp
Chứa mỗi phần tử 1 lần, không có thứ tự [trừ 32 phần tử đầu](http://stackoverflow.com/a/40408469) (tức không thể sắp xếp, phải đổi thành kiểu list mới sắp xếp được.)

```
iex(2)> i MapSet.new([1,2,2,3,2,1])
Term
  #MapSet<[1, 2, 3]>
Data type
  MapSet
Description
  This is a struct. Structs are maps with a __struct__ key.
Reference modules
  MapSet, Map
Implemented protocols
  IEx.Info, Enumerable, Inspect, Collectable
```

### Struct

Struct là dạng đặc biệt của Map, dùng để biểu diễn các kiểu dữ liệu
do người dùng tự định nghĩa.

```
iex(1)> defmodule Person do
...(1)>   defstruct [:name, :age]
...(1)> end
{:module, Person,
 <<70, 79, 82, 49, 0, 0, 8, 20, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0,
   234, 0, 0, 0, 22, 13, 69, 108, 105, 120, 105, 114, 46, 80, 101, 114,
   115, 111, 110, 8, 95, 95, 105, 110, 102, 111, 95, 95, ...>>,
 %Person{age: nil, name: nil}}
iex(2)> i %Person{name: "HVN", age: 27}
Term
  %Person{age: 27, name: "HVN"}
Data type
  Person
Description
  This is a struct. Structs are maps with a __struct__ key.
Reference modules
  Person, Map
Implemented protocols
  IEx.Info, Inspect
```

## Các thao tác cơ bản với các kiểu dữ liệu

### Thao tác với số

- Tính bình phương, căn, sin, cos... sử dụng module `:math` của Erlang
```
iex(11)> :math.pow(2,4)
16.0
iex(12)> :math.sin(2 * :math.pi)
-2.4492935982947064e-16
iex(17)> :math.sqrt(4)
2.0
```

- Convert float thành integer (bỏ phần thập phân)
```
iex(24)> trunc 5.7
5
iex(25)> trunc 5.1
5
```

- Convert string thành integer:
```
iex(26)> "5" |> String.to_integer
5
```

- Làm tròn float thành integer gần nhất
```
iex(28)> round 6.5
7
iex(29)> round 7.5
8
iex(30)> round 7.1
7
```

### Thao tác với String

Chú ý: Để tương thích với Unicode, các function trong String hầu hết có độ phức tạp
là O(n), khá chậm. Thậm chí nếu bạn cần lấy ký tự ở vị trí thứ N, Elixir cũng phải
đi lần lượt từng ký tự cho đến ký tự thứ N.
Nếu không cần xử lý string Unicode, có thể dùng các binary function để có tốc độ O(1).
(Xem chi tiết trong tài liệu của String module).

```
iex(30)> String.length("abcdef")
6
iex(31)> byte_size("abcdef")
6
iex(32)> String.at("abcdef", 5)
"f"
iex(33)> :binary.at("abcdef", 5)
102
iex(34)> binary_part("abcdef", 5, 1)
"f"
```

- Tạo string từ kiểu dữ liệu khác:
```
iex(2)> Integer.to_string(42) <> List.to_string(["a", "b"])
"42ab"
```

- Kiểm tra string con:

```
iex(9)> String.contains?("Python", "on")
true
iex(10)> String.contains?("Python", "ON")
false
```

Chú ý tên function có dấu ?

- Kiểm tra bắt đầu và kết thúc:

```
iex(11)> String.starts_with?("Python", "Py")
true
iex(12)> String
String      StringIO
iex(12)> String.ends_with?("Python.mp3", ".mp3")
true
```

Dễ thấy, những function trả về true/false đều được đặt tên kết thúc bằng dấu ?

- Lấy index #TODO


- Nối các phần tử của list (KHÔNG THỂ NỐI TUPLE):

```
iex(55)> Enum.join(["Python", "PyMi.vn"], " ")
"Python PyMi.vn"
iex(57)> ["Elixir", "PyMi.vn"] |> Enum.join("+")
"Elixir+PyMi.vn"
iex(61)> "Học Python" <> " " <> "tại PyMi.vn"
"Học Python tại PyMi.vn"

iex(7)> Enum.join {1, 2}
** (Protocol.UndefinedError) protocol Enumerable not implemented for {1, 2}
    (elixir) lib/enum.ex:1: Enumerable.impl_for!/1
    (elixir) lib/enum.ex:116: Enumerable.reduce/3
    (elixir) lib/enum.ex:1636: Enum.reduce/3
    (elixir) lib/enum.ex:1154: Enum.join/2
iex(7)> Enum.join [1, 2]
"12"
```

- Cắt string, biến thành list:

```
iex(63)> String.split("Mình thích thì mình học \tthôi", " ")
["Mình", "thích", "thì", "mình", "học", "\tthôi"]
iex(64)> String.split("Mình thích thì mình     học \tthôi")
["Mình", "thích", "thì", "mình", "học", "thôi"]
```

Giống như Python.

Nhưng Elixir còn có thể Split tại nhiều "separator":

```
iex(7)> String.split("a-b+c", ["-", "+"])
["a", "b", "c"]
```

- trim/trim_leading/trim_trailing

```
iex(14)> String.trim("   a\t abc\n")
"a\t abc"
iex(15)> String.trim_leading("   a\t abc\n")
"a\t abc\n"
iex(16)> String.trim_trailing("   a\t abc\n")
"   a\t abc"
```

- replace

```
iex(17)> String.replace("Python", "Py", "Jy")
"Jython"
```

- Chữ hoa, chữ thường:

```
iex(18)> String.upcase("Python")
"PYTHON"
iex(19)> String.downcase("PYThon")
"python"
iex(20)> String.capitalize("python is an animal")
"Python is an animal"
```

- Biến thành kiểu integer

```
iex(22)> String.to_integer("   42  ")
** (ArgumentError) argument error
    :erlang.binary_to_integer("   42  ")
iex(22)> String.to_integer("42")
42

```
Function này trong Elixir không có khả năng bỏ đi whitespace như Python:

```
In [1]: int("   42 \n\t   ")
Out[1]: 42
```

- Lấy độ dài

```
iex(59)>  String.length("Lạc trôi")
8
iex(60)>  String.length("Lạc trôi😝")
9
```

- Slice: slice(string, start, len)

```
iex(1)> String.slice("Python", 0, 2)
"Py"
iex(2)> String.slice("Python", 2, 10)
"thon"
```

- Đảo ngược:

```
iex(4)> String.reverse("DOICAN")
"NACIOD"
```

https://hexdocs.pm/elixir/1.4.2/String.html#content

### List

Sử dụng module `List`. Các function có sẵn của module List không giống như trong Python, bởi List trong Python có thể thay đổi được (thêm bớt, sửa phần tử) còn List trong Elixir thì không.

- Tạo list

```
iex(8)> li = [1, "PyMi", "Python", "Elixir"]
[1, "PyMi", "Python", "Elixir"]
iex(10)> i li
Term
  [1, "PyMi", "Python", "Elixir"]
Data type
  List
Reference modules
  List
```

Từ các kiểu dữ liệu khác:

String thành charlist:

```
iex(5)> String.to_charlist "Elixir"
'Elixir'

```

String thành list
```
iex(7)> String.graphemes("Việt Nam")
["V", "i", "ệ", "t", " ", "N", "a", "m"]
```

- Lấy đầu (head)

```
iex(11)> hd li
1
```

- Lấy đuôi (tail)

```
iex(12)> tl li
["PyMi", "Python", "Elixir"]
```

- Lấy đầu và đuôi:

```
iex(24)> [head | tail] = ["Python", "PyMi", "Golang", "FAMILUG.org"]
["Python", "PyMi", "Golang", "FAMILUG.org"]
iex(25)> head
"Python"
iex(26)> tail
["PyMi", "Golang", "FAMILUG.org"]
```
- Lấy phần tử đầu tiên, cuối cùng
```
iex(9)> List.first ["Python", "Golang", "Elixir"]
"Python"
iex(10)> List.last ["Python", "Golang", "Elixir"]
"Elixir"
```
- Gói dữ liệu vào một list (nếu nó chưa phải 1 list)
```
iex(13)> List.wrap("Lac troi")
["Lac troi"]
iex(14)> List.wrap(0)
[0]
iex(15)> List.wrap(nil)
[]
```

- Kiểm tra số phần tử
```
iex(14)> length li
4
```

- Kiểm tra một phần tử có trong list không

```
iex(5)> Enum.member?([1,2,4], 3)
false
```

Hay dùng cú pháp `left in right`:

```
iex(21)> 1 in [1, 2, 3]
true
```

Chú ý cú pháp `in` này không hoạt động với tuple, map (như trong Python).

```
iex(21)> 1 in {1, 2, 3}
** (Protocol.UndefinedError) protocol Enumerable not implemented for {1, 2, 3}
    (elixir) lib/enum.ex:1: Enumerable.impl_for!/1
    (elixir) lib/enum.ex:131: Enumerable.member?/2
    (elixir) lib/enum.ex:1352: Enum.member?/2
iex(22)> :a in %{:a => value}
** (CompileError) iex:22: undefined function value/0
    (elixir) expanding macro: Kernel.in/2
             iex:22: (file)
```


- Nối 2 list *concatenate*

```
iex(18)> li ++ [2, "Erlang"]
[1, "PyMi", "Python", "Elixir", 2, "Erlang"]
```

- Trừ 2 list *subtract*

```
iex(22)> [1, 2, 3, 2, 1] -- [2]
[1, 3, 2, 1]
iex(23)> [1, 2, 3, 2, 1] -- [2, 3]
[1, 2, 1]
```

- "Thêm" phần tử vào list: thực ra là tạo một list mới
Thêm "Zero" vào index 0

```
iex(21)> List.insert_at(li, 0, "Zero")
["Zero", 1, "PyMi", "Python", "Elixir"]
```

- "Thêm" một phần tử vào đầu list (siêu tốc - constant time O(1)):

```
iex(27)> l3 = ["Python", "PyMi", "Golang", "FAMILUG.org"]
["Python", "PyMi", "Golang", "FAMILUG.org"]
iex(28)> ["h" | l3]
["h", "Python", "PyMi", "Golang", "FAMILUG.org"]
```

- "Thêm" một phần tử xuống cuối list (chậm, linear time O(n))

```
iex(30)> l3 ++ ["t"]
["Python", "PyMi", "Golang", "FAMILUG.org", "t"]
```

- Thay một phần tử của list tại 1 index:
```
iex(33)> List.replace_at(["Python", "PyMi", "Golang", "FAMILUG.org", "t"], 2, "Elixir")
["Python", "PyMi", "Elixir", "FAMILUG.org", "t"]
```

- "Xoá" phần tử khỏi list (dùng value của phần tử và dùng index):

```
iex(31)> List.delete(["Python", "PyMi", "Golang", "FAMILUG.org", "t"], "Golang")
["Python", "PyMi", "FAMILUG.org", "t"]
iex(32)> List.delete_at(["Python", "PyMi", "Golang", "FAMILUG.org", "t"], 2)
["Python", "PyMi", "FAMILUG.org", "t"]
```
- Làm phẳng 1 list (chứa các list khác)
```
iex(11)> List.flatten ["Python", ["Erlang", "Elixir"]]
["Python", "Erlang", "Elixir"]
```

- Lấy một list con từ list (slice):
slice(enumerable, start, amount)

```
iex(36)>  Enum.slice(["Python", "PyMi", "Elixir", "FAMILUG.org"], 1, 10)
["PyMi", "Elixir", "FAMILUG.org"]
```

**Chú ý** argument thứ 3 là só phần tử sẽ slice,
không phải index kết thúc như trong Python.

- Sắp xếp 1 list

Theo bảng chữ cái
```
iex(37)> Enum.sort(["Python", "PyMi", "Elixir", "FAMILUG.org", "t"])
["Elixir", "FAMILUG.org", "PyMi", "Python", "t"]
```

Theo tiêu chí nhất định (function)
```
iex(35)> Enum.sort_by(["Python", "PyMi", "Elixir", "FAMILUG.org", "t"], &String.length/1)
["t", "PyMi", "Python", "Elixir", "FAMILUG.org"]
```

https://hexdocs.pm/elixir/Enum.html#content

### Tuple
Luôn chú ý rằng trong Elixir, mọi kiểu dữ liệu đều là immutable, nên mọi
function thay đổi dữ liệu đều trả về một giá trị mới, không thay đổi đầu vào đã
gọi với function.

Thay một phần tử tại index
```
iex(2)> put_elem {:foo, "bar"}, 1, "bye"
{:foo, "bye"}
```

Thêm một giá trị vào index
```
iex(4)> Tuple.insert_at {"toi", "em"}, 1, "thang ay"
{"toi", "thang ay", "em"}

```

Thêm vào cuối tuple:

```
iex(5)> Tuple.append {6, 9}, "Tail"
{6, 9, "Tail"}
```

Xóa tại index

```
iex(6)> Tuple.delete_at {"Elixir", "is", :not, "great"}, 2
{"Elixir", "is", "great"}
```

Biến thành list
```
iex(7)> Tuple.to_list {:x, :y, :z}
[:x, :y, :z]
```

### Map

là một cấu trúc dữ liệu có thể gọi là "key-value" store.
Tên khác (trong ngôn ngữ khác): dictionary, associative array

```
map = %{:a => 1, :b => 2}
```

- Tạo map:
%{key => value1, key => value2}

```
iex(47)>  %{:a => 1, :b =>2}
%{a: 1, b: 2}
iex(48)> %{"name" => "PYMI", "country" => "VN"}
%{"country" => "VN", "name" => "PYMI"}
```

- Tạo map từ list của các tuple-2:

```
iex(59)> [{1, 7}, {2, 3}] |> Map.new
%{1 => 7, 2 => 3}
```

- Tạo list từ map:

```
iex(60)> [{1, 7}, {2, 3}] |> Map.new |> Map.to_list
[{1, 7}, {2, 3}]
```

- Đếm số phần tử
- Truy cập value:

```
iex(68)> %{:name => who} = %{:name => "HVN"}
%{name: "HVN"}
iex(69)> who
"HVN"

iex(44)> map = %{:a => 1, :b =>2}
%{a: 1, b: 2}
iex(46)> map[:b]
2
iex(47)> map[:c]
nil
```

Hay

```
iex(60)> Map.get(map, :b)
2
iex(64)> Map.get(%{first_name: "Jon", last_name: "Snow"}, :age)
nil
```

Hoặc
```
iex(2)> Map.fetch(%{first_name: "Jon", last_name: "Snow"}, :last_name)
{:ok, "Snow"}
iex(3)> Map.fetch(%{first_name: "Jon", last_name: "Snow"}, :age)
:error
```

- Kiểm tra key có trong map không

```
iex(3)> Map.has_key?(%{:name => "HVN"}, :age)
false
```

- "Thêm" key-value mới:

```
iex(62)> Map.put(%{:a => 1}, :h, 4)
%{a: 1, h: 4}
```

- Xoá key-value:

```
iex(1)> Map.delete(%{:name => "HVN", :age => 27}, :age)
%{name: "HVN"}
```

Xoá key không tồn tại không ảnh hưởng gì:
```
iex(2)> Map.delete(%{:name => "HVN", :age => 27}, :language)
%{age: 27, name: "HVN"}
```

- Duyệt qua từng key # TODO

- Gộp (merge) 2 map
```
iex(6)> Map.merge(%{first_name: "Jon", last_name: "Snow"}, %{last_name: "Water", age: 27})
%{age: 27, first_name: "Jon", last_name: "Water"}
```
- Biến thành list các tuple key-value:

```
iex(63)> Map.to_list(%{:name => "HVN", :age => 27})
[age: 27, name: "HVN"]
```

- Update value của 1 key đã trong map (không thêm):
```
iex(65)> %{ map | :b => 5}
%{a: 1, b: 5}
iex(66)> %{ map | :c => 5}
** (KeyError) key :c not found in: %{a: 1, b: 2}
```

- Truy cập các atom key bằng `.`:

```
iex(66)> student = %{:name => "HVN"}
%{name: "HVN"}
iex(67)> student.name
"HVN"
```

- Update value nested dict với `put_in/2`:

```
iex(70)> users = [hvn: %{name: "HVN", age: 27, language: ["Erlang", "Elixir", "Python"]},
hails: %{name: "HaiLS", age: 26, language: ["Golang", "JS"]}]
[hvn: %{age: 27, language: ["Erlang", "Elixir", "Python"], name: "HVN"},
 hails: %{age: 26, language: ["Golang", "JS"], name: "HaiLS"}]

iex(72)> put_in users[:hvn].age, 29
[hvn: %{age: 29, language: ["Erlang", "Elixir", "Python"], name: "HVN"},
 hails: %{age: 26, language: ["Golang", "JS"], name: "HaiLS"}]
```

- Biến map này thành map khác, sử dụng `Enum.into/3`:

```
iex(2)>  %{a: [1, 2, 3], b: ["meo", "ga"]} |> Enum.into(%{}, fn {k, v} -> {k, length(v)} end)
%{a: 3, b: 2}
```

Mỗi kiểu dữ liệu đều có một module tương ứng cung cấp các function cần thiết: List, Map, String. Module `Enum` dùng chung cho các kiểu dữ liệu cho phép duyệt qua từng phần tử: như `List`

### MapSet
- Kiểm tra phần tử
```
iex(12)> MapSet.member?(MapSet.new([1, 3, 43, 98]) , 9)
false
```

- Các phép toán tập hợp (giao - intersection, hợp - union,...)
```
iex(16)> MapSet.intersection(MapSet.new([1,3,5]), MapSet.new([1,5,2]))
#MapSet<[1, 5]>
#MapSet<[1, 2, 3, 5]>
```

### Struct
Lấy giá trị của field
```
iex(1)> defmodule Person do
...(1)>   defstruct [:name, :age]
...(1)> end
...
iex(3)> Map.fetch %Person{name: "HVN", age: 27}, :name
{:ok, "HVN"}
```

Thay đổi giá trị của các field trong struct
```
iex(4)> hvn = %Person{name: "HVN", age: 27}
%Person{age: 27, name: "HVN"}
iex(5)> %{hvn | age: hvn.age + 1}
%Person{age: 28, name: "HVN"}
```

Thay đổi giá trị của nested value (value của field trong struct trong struct khác ...)
```
iex(2)> defmodule Class do
...(2)>   defstruct person: %Person{}, name: "PyMI"
...(2)> end
...
iex(4)> pymi = %Class{person: %Person{name: "HVN", age: 27}}
%Class{name: "PyMI", person: %Person{age: 27, name: "HVN"}}
iex(5)> put_in pymi.person.age, 28
%Class{name: "PyMI", person: %Person{age: 28, name: "HVN"}}
```

## Pattern matching

`=` : the match operator
- Khi gán biến, biến phải nằm bên trái dấu `=`

```
iex(7)> x = 5
5
iex(8)> 6 = y
** (CompileError) iex:8: undefined function y/0
```

- Vế trái có thể là kiểu dữ liệu phức tạp hơn, dùng để "destructuring" hay "unpacking" dữ liệu phía tay phải.
Số phần tử 2 bên phải bằng nhau, cùng kiểu:

```
iex(18)> {name, age} = {"PyMI.vn", 2}
{"PyMI.vn", 2}
iex(19)> name
"PyMI.vn"
iex(20)> age
2

iex(1)> [x, y, z] = [1, 2, 4]  # list
[1, 2, 4]
iex(2)> x
1
iex(3)> z
4
```

Khi bên phải chứa giá trị thay vì biến, 2 bên chỉ match nhau nếu giá trị bên tay trái match giá trị bên tay phải:

```
iex(4)> {:ok, 1, salary} = {:ok, 1, 15}
{:ok, 1, 15}
iex(5)> {:ok, 1, income} = {:ok, 3, 20}
** (MatchError) no match of right hand side value: {:ok, 3, 20}

iex(10)> {x, x} = {1, 1}
{1, 1}
iex(11)> {x, x} = {1, 2}
** (MatchError) no match of right hand side value: {1, 2}


```
Khi 2 bên không "match", MatchError sẽ xảy ra.

- Matching với cú pháp [head | tail]:

```
iex(5)> [h | t] = [1, 2, 3, 4]
[1, 2, 3, 4]
iex(6)> h
1
iex(7)> t
[2, 3, 4]
```

Giống như gọi function `hd` và `tl`:

```
iex(8)> hd [1, 2, 3, 4]
1
iex(9)> tl [1, 2, 3, 4]
[2, 3, 4]
```

Cú pháp này rõ ràng không match list rỗng:

```
iex(10)> [h | t] = []
** (MatchError) no match of right hand side value: []

```

- Truy cập giá trị của một biến thay vì gán lại nó bằng `^` - pin operator:
```
iex(11)> x = 5
5
iex(12)> x = 7
7
iex(13)> x
7
iex(14)> ^x = 8
** (MatchError) no match of right hand side value: 8
Vì giống như viết: 7 = 8
iex(14)> 7 = 8
** (MatchError) no match of right hand side value: 8
```


## Control flow: case, cond, if, unless, do/end

### if

if/2 là một function, tức nó sẽ trả về một giá trị sau khi chạy. Khác với Python hay nhiều ngôn ngữ khác, if trong Python là một "statement" (câu lệnh), và nó chỉ thực hiện điều khiển luồng chứ không trả về giá trị nào.
(PS: thực sự if/2 mà 1 macro - khái niệm macro sẽ được nói sau)

```
iex(15)> k = if 5 > 4 do
...(15)> "yeah"
...(15)> end
"yeah"
iex(16)> k
"yeah"
```

if/2 trả về nil nếu điều kiện nó nhận được trả về false hay nil.

```
iex(17)> h = if 5 < 4 do
...(17)> "hey"
...(17)> end
nil
iex(18)> h
nil
```

Mẫu cú pháp:

```
if condition do
SOMETHING
end
```

`if` có thể đi kèm với `else`:
```
iex(19)> m = if 5 < 4 do
...(19)> "smaller"
...(19)> else
...(19)> "bigger"
...(19)> end
"bigger"
iex(20)> m
"bigger"
```

Trong Elixir chỉ có `if/else/end` không có elif như trong Python, khi cần xử lý nhiều trường hợp, ta có thể dùng cond.

Đọc thêm: https://hexdocs.pm/elixir/Kernel.html#if/2

### cond
`cond do ... end` cho phép xử lý nhiều điều kiện, giống như elif hay else if trong các ngôn ngữ khác:

```
iex(24)> x = 18
18
iex(25)> cond do
...(25)>   x < 18 ->
...(25)>     "Not permitted"
...(25)>   x == 18 ->
...(25)>     "Okay"
...(25)>   x > 18 ->
...(25)>     "Too old"
...(25)> end
"Okay"
```

### unless
Như if, nhưng ngược lại.

```
iex(26)> x = 18
18
iex(27)> unless x < 18 do
...(27)>   "got this"
...(27)> end
"got this"
iex(28)> if x < 18 do
...(28)>   "no"
...(28)> end
nil
```

### case
`case` sử dụng pattern matching, và chỉ dừng lại khi ta tìm thấy giá trị nào match. Ta thấy `case` chỉ dùng để kiểm tra xem 1 giá trị có bằng một giá trị khác, chứ không dùng so sánh >, < ... như `if`.

```
iex(22)> case 5 do
...(22)>   4 ->
...(22)>
...(22)> "Won't match"
...(22)> _ ->
...(22)> "will match"
...(22)> end
"will match"
```

```
iex(23)> case {1, 2, 3} do
...(23)>   {1, x, 3} when x > 0 ->
...(23)>     "will match"
...(23)>   _ ->
...(23)>     "Would match, if guard cond were not sastified"
...(23)> end
"will match"
```


`when x > 0` gọi là guard condition. Ta thấy `case` cũng là một macro chứ không phải "statement" như trong các ngôn ngữ khác.


Cú pháp:

```
case SOMETHING do
  CLAUSE1 [GUARD] ->
      "OTHERTHING"
  CLAUSE2 [GUARD] ->
     ...
  _ ->
     "LAST PATTERN MATCH REMAIN"
end
```

Nếu không clause nào match, error sẽ được raise:

```
iex(24)> case :ok do
...(24)>   :error ->
...(24)>     "Not match"
...(24)> end
** (CaseClauseError) no case clause matching: :ok

```


### Guard
Trong guard không được dùng && || !
Error trong guard sẽ khiến guard fail.


### do/end
Trong `if` `unless` `cond` `case` đều có dùng `do` và
kết thúc bằng `end`.

```
if true do
...
end
```

Tương đương với:

```
if true, do: (
...
)
```
`do/end` là syntactix sugar (cú pháp để viết cho dễ).

## Function

### Gọi function (calling):

Cú pháp thông thường:

```
iex(1)> String.to_integer(String.trim("  42 \n "))
42
iex(7)> String.split("42-15\n17", ["-", "\n"])
["42", "15", "17"]
```

Cú pháp bỏ dấu `()`:

```
iex(8)> String.split "42-15\n17", ["-", "\n"]
["42", "15", "17"]

iex(10)> Enum.map(String.split("42-15\n17", ["-", "\n"]), fn(x) -> String.to_integer(x) end)
[42, 15, 17]
```

#### Toán tử pipe (pipe operator)
Cú pháp sử dụng "pipe", dữ liệu sẽ chạy từ output của 1 function, qua pipe và trở thành argument đầu tiên của function tiếp theo (giống Pipeline trên UNIX shell).

```
iex(11)> String.split("42-15\n17", ["-", "\n"]) |> Enum.map(fn(x) -> String.to_integer(x) end)
[42, 15, 17]

iex(23)> 1..1000 |> Enum.filter(fn(x) -> (rem(x, 3) == 0 || rem(x, 5) == 0) end) |> Enum.sum
234168
```

### Định nghĩa function
Function có tên phải được định nghĩa trong module.
Function sẽ trả về giá trị cuối cùng nó tính được - không có câu lệnh "return".
Đoạn code sau định nghĩa module `Math` và function `sum` trả về tổng của 2 argument a, b:

```
defmodule Math do
  def sum(a, b) do
    a + b
  end
end
```

hoặc

```
defmodule Hacker, do: def hack(x), do: x*2
```
khi chỉ có 1 function và function chỉ có 1 dòng.

`defmodule` và `def` đều là các macro.

### Private function
Định nghĩa bằng macro `defp/2`, từ module khác không thể chạy các function này.

### Ký hiệu (notation)
Khi nhắc tới function, trong Elixir dùng ký hiệu:
`name/arity` với name là tên , và arity là số argument function đó nhận.

Math.sum ở trên ký hiệu là `Math.sum/2`

### Multiple clause function
Một function có thể có nhiều `clause`:

Mỗi "clause" thường đi kèm một "guard", nếu argument pass vào match với argument của clause và guard đi kèm trả về `true`, clause đó sẽ được gọi.

```
defmodule Foo do
  def rprint(msg, n) when n <= 1 do
    IO.puts msg
  end

  def rprint(msg, n) do
    IO.puts msg
    rprint(msg, n - 1)
  end
end

Foo.rprint("Hello", 5)
```

### Function capturing

#### TODO

### Default argument

```
def join(a, b, sep \\ ",") do
  a <> sep <> b
end
```
"," là default argument, khi gọi funtion mà không pass giá trị cho argument `sep`, `sep` sẽ sử dụng giá trị mặc định ",".

### Các phần của một function

```
def sum(a, b) do
  a + b
end
```

- Function head: `def sum(a, b)`
- Function body: từ `do` đến `end`

Khi function với default value có nhiều mệnh đề, phải khai báo một function head để khai báo giá trị default.

#### TODO more detail

## Module

### Compile

Có thể viết module vào file `NAME.ex`: `math.ex`.

Compile module:

```
$ elixirc math.ex  # tạo ra file Elixir.Math.beam
```

Bật `iex` cùng thư mục sẽ tự động load module, chỉ việc gọi.

### Script
Lưu file với đuôi .exs, Elixir sẽ hiểu đó là 1 "script" và sẽ không tạo file có đuôi .beam nữa, chạy nó như chạy các script khác (Python, bash...):

```
$ elixir math.exs
```

## Loop bằng recursion, reduce và map

Trong Elixir, mọi thứ đều là "immutable" (không thay đổi được), vì vậy những khái niệm để lặp như trong các ngôn ngữ C, Python, Java, PHP, Golang ... sẽ không được ứng dụng:

```
for i in 'Elixir':
    print(i)
```

Ở vòng lặp for này, giá trị của i lần lượt thay đổi thành các ký tự trong "Elixir" -> không đảm bảo được tính immutable của Elixir.

```
i = 0
while True:
    print(i)
    i = i + 1
```

Tương tự, trong vòng lặp while này i cũng thay đổi sau mỗi vòng lặp, không đảm bảo tính immutable.

Elixir hay các ngôn ngữ lập trình hàm (functional programming language) khác sử dụng recursive function để tạo hiệu ứng/ kết quả như loop.

### Recursive function
Là function mà bên trong phần body, nó tự gọi đến chính nó cho đến khi gặp một điều kiện để dừng lại. Sẽ không có gì bị thay đổi khi dùng recursive function, bởi ta sẽ sinh ra giá trị mới, chứ không thay đổi giá trị cũ. Mọi khái niệm sẽ rõ ràng khi thử với function tính giai thừa của 1 số:

Giai thừa của một số nguyên không âm được tính bằng tích của số đó nhân với giai thửa của số nhỏ hơn nó 1 đơn vị. Hay viết ở dạng công thức toán:
factorial(n) = n * factorial(n - 1)
khi n = 0 thì factorial(0) = 1. # điều kiện dừng

Thử tính factorial của 3:

factorial(3) = 3 * factorial(2)
factorial(2) = 2 * factorial(1)
factorial(1) = 1 * factorial(0)
factorial(0) = 1

Sau khi đã chạm đến điều kiện dựng, ta lấy kết quả thu được thay ngược lên trên.
factorial(1) = 1 * factorial(0) = 1 * 1 = 1
factorial(2) = 2 * factorial(1) = 2 * 1 = 2
factorial(3) = 3 * factorial(2) = 3 * 2 = 6

Kết quả là factorial(3) bằng 6.

```
defmodule Rescusion do
  def fact(n) when n <= 0 do
    1
  end

  def fact(n) do
    n * fact(n - 1)
  end
end
```

Trong bài này, code của Elixir chỉ đơn giản là chuyển công thức toán học thành code.

### Map
Một việc làm thường xuyên khi sử dụng loop là để biến 1 tập giá trị, thành 1 tập giá trị khác.

Ví dụ, cho một list `L = [1, 2, 3 ,4]`, cần thu được kết quả là một list mà phần tử của nó là mỗi phần tử của `L` nhân với 2.

Việc biến một tập thành một tập khác bằng cách gọi function với mỗi phần tử của tập gọi là "mapping" (ánh xạ trong toán học).
Ta "map" một phần tử từ tập ban đầu thành phần tử trong tập mới.

Viết function để map list nói trên:

```
iex(41)> defmodule Double do
...(41)>   def double_each([head | tail]) do
...(41)>     [head * 2 | double_each(tail)]
...(41)>   end
...(41)>
...(41)>   def double_each([]) do
...(41)>     []
...(41)>   end
...(41)> end
{:module, Double,
...
iex(42)> Double.double_each([1,2,3,4])
[2, 4, 6, 8]
```

Có thể dùng function có sẵn `Enum.map/2` để thực hiện mapping:

```
iex(45)> Enum.map([1,2,3,4], fn(x) -> x * 2 end)
[2, 4, 6, 8]
```

### Reduce
Một ứng dụng khác thường dùng khi lặp là để tính một giá trị nào đó sẽ thu được sau khi duyệt qua tất cả giá trị trong tập, như tính tổng, tích của tập.

Ở đây ta biến từ 1 tập nhiều phần tử thành 1 giá trị cuối cùng. Việc "thu gọn" này có tên là "reducing".

Map và reduce là 2 thuật toán cốt lõi của "big data".

```
iex(46)> defmodule Reduce do
...(46)>   def sum_list([head | tail], accumulator) do
...(46)>     sum_list(tail, head + accumulator)
...(46)>   end
...(46)>
...(46)>   def sum_list([], accumulator) do
...(46)>     accumulator
...(46)>   end
...(46)> end

iex(47)> Reduce.sum_list([1,2,3], 0)
6
```

Hay dùng module có sẵn `Enum.reduce/2`:

```
iex(48)> Enum.reduce([1,2,3], 0, fn(x, acc) -> x + acc end)
6
```

## IO - xử lý dữ liệu vào ra.
### In ra màn hình

Mặc dù hầu hết các sách dạy lập trình / trường học sẽ luôn bắt đầu bằng việc dạy "print" ra màn hình (và đi kèm là đọc những gì người dùng nhập vào), nhưng trên thực tế, có khoảng < 5% người thực sự dùng print trong chương trình của mình.

Hãy thử nghĩ với người dùng Windows, có bao giờ bạn bật `cmd` lên và gõ lệnh? Các chương trình đều giao tiếp với người dùng qua giao diện đồ hoạ / web, chứ không phải các dòng lệnh. Những người làm việc với dòng lệnh chủ yếu là các Linux Sysadmin / lập trình viên / hacker.
Nếu bạn là một web developer, bạn đưa nội dung ra trang web chứ không print nó.

Elixir sử dụng module `IO` cho các thao tác này:

```
iex(49)> IO.puts "Hello"
Hello
:ok
iex(50)> IO.puts "Hello FAMILUG"
Hello FAMILUG
:ok
iex(51)> answer = IO.gets("yes or no? ")
yes or no? yes
"yes\n"
iex(52)> IO.puts(answer)
yes

:ok
```

Có thể ghi ra stderr:

```
iex(53)> IO.puts(:stderr, "Hello standard error")
Hello standard error
:ok
```

Để không thêm ký tự newline (`\n`) sau mỗi dòng, sử dụng `IO.write` thay
vì `IO.puts`.

`puts` chỉ nhận argument là string, muốn "in ra" một list, tuple hay object bất
kỳ, hãy dùng `IO.inspect`.

Khi dùng `IO.inspect` in ra list có nhiều phần tử (>50), Elixir sẽ chỉ in ra 50
phần tử đầu và ghi ... để ký hiệu còn tiếp. Muốn hiện đầy đủ, có thể gọi thêm
argument:

```
iex(9)> IO.inspect(1..100|>Enum.map(fn x -> x*2 end))

[2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38,
 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74,
 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, ...]

iex(10)> IO.inspect(1..100|>Enum.map(fn x -> x*2 end), limit: :infinity)
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42,
 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82,
 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116,
 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148,
 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180,
 182, 184, 186, 188, 190, 192, 194, 196, 198, 200]

```

### Đọc ghi file

Module `File` chứa các function để tương tác với file, từ đọc, ghi, xoá, copy...


```
iex(53)> IO.puts(:stderr, "Hello standard error")
Hello standard error
:ok
iex(54)> {:ok, file} = File.open("hellofile.txt", [:write])
{:ok, #PID<0.260.0>}
iex(55)> IO.binwrite(file, "Hello world!")
:ok
iex(56)> File.close(file)
:ok
iex(57)> File.read("hellofile.txt")
{:ok, "Hello world!"}
```

Các function xử lý file:

`File.rm/1`, `File.mkdir/1`, `File.cp_r/2`, ...

## Xử lý lỗi

### Errror (hay exception)

```
iex(58)> "abc" + 1
** (ArithmeticError) bad argument in arithmetic expression
    :erlang.+("abc", 1)
iex(58)> raise "oizoioi"
** (RuntimeError) oizoioi

iex(58)> raise ArgumentError, message: "invalid argument"
** (ArgumentError) invalid argument

```

### try/rescue/catch/after
Tương tự như try/except trong Python hay try/catch trong Java, Elixir có try/recuse và try/catch, nhưng trong Elixir, sử dụng chúng là điều không nên / hiếm khi dùng.

```
iex(61)> try do
...(61)>   r = 1/0
...(61)> rescue
...(61)>   ArithmeticError -> "Error"
...(61)> end
"Error"
```

Vậy Elixir làm gì khi gặp lỗi? có "exception" thì xử lý thế nào?
Trong triết lý của Erlang/Elixir, "lỗi" là một phần của chương trình, và hệ thống nằm dưới ngôn ngữ (BEAM/OTP) sẽ xử lý chúng một cách ngon lành. Tạm thời bỏ qua ở đây.

## Bắt đầu code một project
Đến đây đã đủ các công cụ cơ bản để viết những chương trình bình thường / luyện tập với các thuật toán ... cho đến khi quen với ngôn ngữ.
Elixir còn nhiều khái niệm khác, đặc biệt được đưa ra để xử lý trong môi trường "phân tán", nhưng tập trung vào những tính năng đó ngay bây giờ chỉ làm cho người học bị quá tải với những khái niệm mới lạ, trong khi vẫn chưa nắm rõ phần cơ bản. Vậy nên, các khái niệm "khác" đó sẽ được dành cho phần sau. Còn bây giờ, tạo một project Elixir và code:

`Mix` là "build tool" của Elixir, để tạo một project mới, dùng câu lệnh:

```
 mix new hello_familug
* creating README.md
* creating .gitignore
* creating mix.exs
* creating config
* creating config/config.exs
* creating lib
* creating lib/hello_familug.ex
* creating test
* creating test/test_helper.exs
* creating test/hello_familug_test.exs

Your Mix project was created successfully.
You can use "mix" to compile it, test it, and more:

    cd hello_familug
    mix test

Run "mix help" for more commands.
```

Sửa nội dung file `lib/hello_familug.ex` như sau:

```
defmodule HelloFamilug do
  def main(args) do
    IO.puts "Hello FAMILUG!"
  end
end
```

Thêm dòng:

```
      escript: escript,
```

vào sau dòng

```
      elixir: "~> VERSION",
```

trong mix.exs.

Thêm function sau vào trong file `mix.exs`

```
  def escript do
    [main_module: HelloFamilug]  # tên module sẽ được chạy
  end
```

Compile và chạy:

```
$ mix escript.build
Compiling 1 file (.ex)
warning: variable args is unused
  lib/hello_familug.ex:2

Generated hello_familug app
Generated escript hello_familug with MIX_ENV=dev
$ ./hello_familug
Hello FAMILUG!
```

Sửa lại code để nhận vào input từ người dùng:

```
defmodule HelloFamilug do
  def main(args) do
    {_, [name], _} = OptionParser.parse(args)
    IO.puts "Hello " <> name
  end
end
```

Tạm thời bỏ qua chi tiết OptionParser.parse/1 làm gì,
build lại và gọi với một cái tên:

```
$ mix escript.build
Compiling 1 file (.ex)
Generated escript hello_familug with MIX_ENV=dev
$ ./hello_familug Python
Hello Python
```

Chương trình dòng lệnh (CLI tool) không phải là thế mạnh của Elixir, nhưng nó hoàn toàn có thể làm được và không hề phức tạp. Với từng ấy đủ để ta bắt đầu cuộc hành trình vào những giấc mơ sâu vô tận trong thế giới của nhà giả kim và Elixir (thuốc tiên).


## FAQs
### Tại sao tên lại nhảm nhí vậy "học Elixir trong một giấc mơ"?

Vì việc đọc tiếng Anh ở Việt Nam rất "thảm hoạ".
Chữ "Python" - rõ ràng đọc là "pai-thon" thì phần lớn lập trình viên lại đọc là "Pi-thông". Vậy nên tôi đặt tên có vần để người học có thể đọc đúng "Học `i lík sơ` trong một giấc mơ".
