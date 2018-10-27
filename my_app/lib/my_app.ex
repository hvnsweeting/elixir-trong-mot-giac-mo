defmodule MyRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    IO.inspect conn
    send_resp(conn, 200, "world")
  end

  get "/json/:name" do
    conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Poison.encode!(%{name: name}))
  end

  #forward "/users", to: UsersRouter

  match _ do
    send_resp(conn, 404, "oops")
  end
end

