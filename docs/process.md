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

```elixir
iex(34)> send self(), 5
5
iex(35)> send self(), 7
7
iex(36)> send self(), 9
9
iex(37)> flush()
5
7
9
:ok
```


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
## Tính toán "song song" với Task.async
Chạy một function theo kiểu "async" rất đơn giản, `Task.async` sẽ chạy và
return task đó
```elixir
iex(16)> t = Task.async(fn -> 3 * 3 end)
%Task{owner: #PID<0.85.0>, pid: #PID<0.130.0>,
 ref: #Reference<0.83711.2587885569.77446>}
```

Đợi rồi lấy kết quả bằng cách gọi Task.await với task đã chạy function tính
toán
```elixir
iex(17)> Task.await(t)
9
```

Nhiều khi, đợi chờ không phải là hạnh phúc, ta dùng `Task.yield`, ta nhận được
kết quả hoặc `nil` nếu chưa tính xong.

```elixir
iex(21)> t = Task.async(fn -> 1 + 1 end)
%Task{owner: #PID<0.85.0>, pid: #PID<0.137.0>,
 ref: #Reference<0.83711.2587885569.77738>}
iex(22)> Task.yield(t)
{:ok, 2}

iex(28)> t = Task.async(fn ->
...(28)>   :timer.sleep(10000)
...(28)>   1 + 1
...(28)>   end)
%Task{owner: #PID<0.85.0>, pid: #PID<0.156.0>,
 ref: #Reference<0.83711.2587885569.79354>}
iex(29)> Task.yield(t)  # mặc định chờ 5000 ms
nil
```

Tính toán song song

```elixir
iex(35)> [1,2,3,4]
|> Enum.map(fn x -> Task.async(fn -> x * x end) end)
|> Task.yield_many(100)
|> Enum.map(fn({_task, {:ok, result}}) -> result end)
[1, 4, 9, 16]
```

# Gửi message qua lại giữa 2 process
Những ví dụ đơn giản trên chỉ gửi message từ một process đến process còn lại mà không hề có phản hồi,
để process Y phản hồi sau khi nhận được message từ X, Y phải biết "địa chỉ" của X - ở đây là PID. Vì vậy khi gửi message, ta gửi kèm PID của process gửi (giống như gửi thư, muốn nhận phải ghi địa chỉ người nhận). Để quá trình này trông giống như 2 process cùng đang chạy và nói chuyện với nhau, ta sẽ viết function cho process nhận sẽ chạy mãi cho đến khi nhận được message có chứa atom :quit.

Định nghĩa 1 module và viết vào 1 file có tên bất kỳ:

```elixir
defmodule CoolProcess do
  def loop() do
    receive do
      {:msg, msg, pid} ->
        send(pid, {:msg, "Got it:" <> msg , self()})
        loop()
      {:quit, pid} ->
        send(pid, {"Goodbye", self()})
      {_, pid} ->
        send(pid, {"I dont understand you", self()})
        loop()
      _ ->
        IO.puts "What?"
        loop()
    end
  end

  def start_link do
    Task.start_link(fn -> loop() end)
  end
end

```

Ở mỗi trường hợp (trừ {:quit, pid}), function loop() sẽ gọi lại chính nó, tạo nên một vòng lặp vô hạn, nhưng ta sẽ không bị lỗi gì liên quan đến giới hạn recursive bởi các câu gọi `loop()` đều là câu lệnh cuối cùng, Elixir biết cách xử lý những trường hợp như vậy - và nó có tên là "tail recursive".

Giờ chạy `iex filename.exs` và gọi function của CoolProcess.start_link/0 để tạo một process mới,
gửi các message đến nó và nhận phản hồi, gửi {:quit, PID} để tắt process (do khối code tương
ứng khi nhận được :quit không gọi loop() nữa )

```elixir
iex(3)> {:ok, pid} = CoolProcess.start_link
{:ok, #PID<0.90.0>}
iex(4)> Pro
Process     Protocol
iex(4)> Process.alive? pid
true
iex(5)> send pid, {:msg, "hello", self()}
{:msg, "hello", #PID<0.84.0>}
iex(6)> flush()
{:msg, "Got it:hello", #PID<0.90.0>}
:ok
iex(7)> send pid, {:nothing, self()}
{:nothing, #PID<0.84.0>}
iex(8)> flush()
{"I dont understand you", #PID<0.90.0>}
:ok
iex(9)> send pid, {:quit, self()}
{:quit, #PID<0.84.0>}
iex(10)> flush()
{"Goodbye", #PID<0.90.0>}
:ok
iex(11)> Process.alive? pid
false
```


Những khái niệm "process", send, receive không quá phức tạp là phần cốt yếu đểu giúp Erlang/Elixir tạo nên những hệ thống có thể chạy hàng trăm ngàn process cùng một lúc. Khi vấn đề là một, hai process, chúng ta quan tâm đến từng process, nhưng khi bài toán lớn lên, ta sẽ cần quan tâm đến việc làm sao quản lý được nhiều process, và điều khiển chúng chạy thế nào cho phù hợp. Phần #TODO sẽ đi chi tiết vào việc quản lý các process với sức mạnh của OTP.

## Tham khảo
- https://elixir-lang.org/getting-started/processes.html
- http://learnyousomeerlang.com/the-hitchhikers-guide-to-concurrency
