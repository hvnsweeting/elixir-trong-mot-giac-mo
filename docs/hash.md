# Hash
Hash function là function nhận đầu vào tùy ý, sinh ra kết quả (thường biểu diễn
ở dạng string) có độ lớn cố định.
Chỉ cần thỏa mãn yêu cầu như vậy là đã có thể trở thành 1 hash function.
Có [rất nhiều các hash function](https://en.wikipedia.org/wiki/List_of_hash_functions#Non-cryptographic_hash_functions), mỗi loại sẽ có tính chất riêng, phục vụ cho những mục đích riêng.
Chú ý: không phải hash function nào cũng dùng được trong bảo mật.

`md5`, `sha1`, `sha256` là những hash function nổi tiếng nhất.
Elixir hỗ trợ gọi các hash function từ Erlang, thông qua module `:crypto`.

```elixir
iex(17)> :crypto.hash(:md5, "123456") |> Base.encode16 |> String.downcase
"e10adc3949ba59abbe56e057f20f883e"
iex(18)> :crypto.hash(:sha256, "123456") |> Base.encode16 |> String.downcase
"8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92"
```

Kiểm tra kết quả so với dòng lệnh trên Linux:

```bash
$ echo -n 123456 | md5sum
e10adc3949ba59abbe56e057f20f883e  -
$ echo -n 123456 | sha256sum
8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92  -
```

Kết quả như nhau.

Khi cần tính hash những gì lớn hơn 1 string (ví dụ 1 file video 1GB),
ta phải khởi tạo, update nhiều lần qua từng phần của file, rồi tính ra mã hash
cuối cùng. Ví dụ ta chia `123456` thành `123` và `456`.

```elixir
iex(19)> md5 = :crypto.hash_init(:md5)
#Reference<0.104787425.3088711681.39290>
iex(20)> md5 = :crypto.hash_update(md5, "123")
#Reference<0.104787425.3088711681.39875>
iex(21)> md5 = :crypto.hash_update(md5, "456")
#Reference<0.104787425.3088711681.39890>
iex(22)> :crypto.hash_final(md5) |> Base.encode16 |> String.downcase
"e10adc3949ba59abbe56e057f20f883e"
```
