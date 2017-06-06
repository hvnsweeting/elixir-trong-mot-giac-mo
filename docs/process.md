Dù trong Elixir hay Python hay bất cứ ngôn ngữ nào thì code cũng chạy trong process. 

Nhưng process trong Elixir (không phải process cung cấp bởi hệ điều hành mà là process do chính máy ảo BEAM thiết kế và vận hành) có những tính năng vượt trội giúp người dùng có thể dễ dàng viết chương trình chạy đồng thời, phân tán.

Khái niệm process/thread luôn là một khái niệm phức tạp / lằng nhằng trong những ngôn ngữ khác nhưng với Elixir/Erlang, nó trở nên đơn giản hơn nhiều.

# Tạo một process
Để sinh một process và chạy một function trong process đó, dùng function `spawn/1`, function này trả về PID (process identifier) - một con số để xác định process này, giúp ta có thể gửi tin nhắn cho process này hay tắt nó...

```elixir
iex(9)> pid = spawn fn -> 1 + 2 end
#PID<0.93.0>
```

Ngay khi chạy xong function, process sẽ tự kết thúc. Kiểm tra xem process còn sống không:

```elixir
iex(11)> h Process.alive?/1

Returns true if the process exists and is alive (i.e. it is not exiting and has
not exited yet). Otherwise, returns false.

pid must refer to a process at the local node.

iex(12)> Process.alive? pid
false
```

Kết quả là false, tức process của ta đã chết (exit) sau khi nó hoàn thành function.

Kiểm tra process chính đang chạy chương trình mà ta đang gõ lệnh:

```elixir
iex(13)> Process.alive? self()
true
iex(14)> self()
#PID<0.80.0>
```

`self/0` trả về PID của process hiện tại.


# Gửi nhận message /ˈmɛsɪdʒ/

When a message is sent to a process, the message is stored in the process mailbox. The receive/1 block goes through the current process mailbox searching for a message that matches any of the given patterns. receive/1 supports guards and many clauses, such as case/2.

## Actor model 
Các process trong Elixir có thể gửi message (tin nhắn) cho nhau. Đây là cơ chế hoạt động của Erlang/Elixir khi 2 process cần trao đổi bất kỳ thông tin gì và thường được nhắc tới như "Actor model".

## Asynchronous /eɪˈsɪŋkrənəs/
Khi process X gửi message tới process Y, message này được chứa trong mailbox của Y. Gửi xong X sẽ tiếp tục công việc của nó chứ không đợi (block) Y nhận hay xử lý message. Cơ chế không đợi này gọi là  asynchronous (có tính bất/không đồng bộ)
 Cú pháp gửi rất đơn giản:

```elixir
iex(22)> me = self()
#PID<0.80.0>
iex(23)> send me, {:hello, "world"}
{:hello, "world"}
iex(24)> send me, {:hello, "PyMi"}
{:hello, "PyMi"}
iex(25)> receive do
...(25)>   msg -> msg
...(25)> end
{:hello, "world"}
iex(26)> receive do
...(26)>   msg -> msg
...(26)> end
{:hello, "PyMi"}
iex(27)>
```

Message được gửi (từ chính process hiện tại) được chứa trong mailbox, khi dùng `receive do... end`, ta nhận được từng message theo thứ tự gửi trước nhận trước (FIFO - queue).

## Synchronous /ˈsɪŋkrənəs/
Với ngôn ngữ khác, như Golang, khi A gửi "thông tin" cho B quan channel, A sẽ dừng lại, đợi (block) cho đến khi B xử lý xong mới tiếp tục. Cơ chế đợi đối phương thực hiện như thế này gọi là "synchronous" (có tính đồng bộ).


## Receive
Nếu trong mailbox có message, process gọi `receive do ...end` sẽ xử lý ngay message đó, nhưng nếu không có message nào, nó sẽ đợi (block) cho đến khi có message.
Trừ khi được gọi với "after" để thực hiện "timeout" sau một khoản thời gian cố định. Ví dụ code sau sẽ đợi message trong 2s (2000 milli giây):

```elixir
iex(27)> receive do
...(27)>   msg -> msg
...(27)> after 2_000 -> "Nothing after 2s"
...(27)> end
"Nothing after 2s"
```

`receive` có hỗ trợ pattern matching.

## Sinh process để gửi message

```Elixir
iex(28)> parent = self()
#PID<0.80.0>
iex(29)> spawn fn -> send(parent, {:hello, self()}) end
#PID<0.129.0>
iex(30)> receive do
...(30)>   {:hello, pid} -> "Got hello from #{inspect pid}"
...(30)> end
"Got hello from #PID<0.129.0>"
```

function `flush/0` giúp "flush" và in tất cả các messages đang nằm trong mailbox.

# Tasks
Task là khái niệm xây dựng trên `spawn/1` để tạo process, nhưng cung cấp nhiều tính năng hơn. Cách dùng tương tự `spawn/1` nhưng trả về tuple {:ok, pid} thay vì PID như `spawn/1`

```elixir
iex(32)> Task.start fn -> send(parent, {:hello, self()}) end
{:ok, #PID<0.136.0>}
iex(33)> receive do
...(33)>   {:hello, pid} -> "Got hello from #{inspect pid}"
...(33)> end
"Got hello from #PID<0.136.0>"
```