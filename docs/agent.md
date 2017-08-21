# Agent
Agent dùng để chứa trạng thái (giá trị).

Agent.start_link nhận vào 1 function.
Fucntion đó không nhận đầu vào, trả về giá trị khởi tạo mà agent sẽ chứa.

Để truy cập giá trị agent chứa, ta gọi Agent.get với PID của agent
```elixir
iex(37)> {:ok, pid} = Agent.start_link(fn -> "Hello" end)
{:ok, #PID<0.184.0>}
iex(38)> Agent.get(pid, &(&1))
"Hello"
```
Thay vì truy cập agent qua PID, có thể gán name cho một agent
```elixir
iex(39)> {:ok, pid} = Agent.start_link(fn -> "Hello" end, name: Agent007)
{:ok, #PID<0.187.0>}
iex(40)> Agent.get(Agent007, &(&1))
"Hello"
```

Có thể update giá trị mà Agent đang lưu trữ với Agent.update
```elixir
iex(41)> Agent.update(Agent007, fn(old) -> String.upcase(old) end)
:ok
iex(42)> Agent.get(Agent007, &(&1))
"HELLO"
```

# GenServer
