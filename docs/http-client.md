# HTTP & JSON

Sau khi đã nắm được các khái niệm cơ bản của Elixir, thì một việc ắt phải làm vì vô cùng quan trọng: đó là biết cách dùng thư viện ngoài (thư viện không có sẵn khi cài Elixir/ thư viện bên thứ 3).

## Chọn thư viện nào?

Câu hỏi tưởng chừng đơn giản này thực ra là một câu hỏi rất nguy hiểm, khó trả lời, cũng cùng kiểu như câu "tối nay ăn gì" đã khiến cho hàng ngàn cặp đôi rơi vào những cuộc cãi cọ...

Ta không cần phải đau đầu hay đắn đo gì, một thư viện hỗ trợ gửi HTTP request (GET/POST) sẽ là thứ hữu dụng và thực tế nhất bạn có thể dùng. Chỉ đơn thuần biết dùng HTTP client gọi vào các API, ta đã có một đống dữ liệu để làm ra một cái gì đó có ích.
Dữ liệu trả về khi ta gọi các API sẽ có format JSON, một thư viện JSON sẽ là vô cùng quan trọng ở đây.

### HTTPotion - HTTP client
Elixir chạy trên máy ảo BEAM của Erlang, nên thư viện HTTP client của Erlang thì đã sẵn, hoàn thiện hàng chục năm rồi. Người ta chỉ cần thêm bớt một chút sao cho trông nó "Elixir" hơn là được.

[HTTPotion](https://github.com/myfreeweb/httpotion) là thư viện được lựa chọn ở đây, nó cũng có vẻ là thư viện phổ biến nhất trong các HTTP client của Elixir.  HTTPotion xây dựng dựa trên thư viện "hackney" của Erlang.

Việc quản lý các thư viện được Mix xử lý rất đơn giản:
- Thêm tên của thư viện vào list trong function `deps`
- Chạy `mix deps.get` để tải thư viện về
- Bật `iex -S mix` để load thư viện vào rồi dùng trong chế độ interactive.


```
defp deps do
  [
    {:poison, "~> 3.1"}
    {:httpotion, "~> 3.0.2"},
    #...
  ]
end
```

### Poison - JSON library
Ta cài [thư viện Poison - thư viện xử lý JSON](https://github.com/devinus/poison) phổ biến nhất của Elixir.


## Lấy dữ liệu từ GitHub API
Thử dùng bộ đôi thư viện này để lấy danh sách các contributor của [SaltStack](https://github.com/saltstack/salt/) dùng GitHub API:

```
iex(2)> {:ok, response} = HTTPoison.get "https://api.github.com/repos/saltstack/salt/contributors?page=3"
{:ok,
 %HTTPoison.Response{body: "[{\"login\":\"kjkuan\",\"id\":973329,\"avatar_url\":\"
...

iex(5)> {:ok, contribs} = Poison.decode(Map.get(response, :body))
{:ok,
 [%{"avatar_url" => "https://avatars3.githubusercontent.com/u/973329?v=3",
    "contributions" => 88,
    "events_url" => "https://api.github.com/users/kjkuan/events{/privacy}",
...

iex(6)> contribs |> Enum.map(fn contrib -> Map.get(contrib, "login") end)
["kjkuan", "thedrow", "alexbleotu", "bdrung", "robertkeizer", "hvnsweeting",
 "jhutchins", "giantlock", "aboe76", "multani", "herlo", "0xf10e", "ranl",
 "evinrude", "baijum", "cedwards", "lorengordon", "syphernl", "bbinet", "m03",
 "kaithar", "MTecknology", "rominf", "akissa", "claudiupopescu", "jodv",
 "inthecloud247", "castor-morveer", "fxdgear", "markusgattol"]
```

Đơn giản, ngắn gọn, sạch sẽ 🏆
