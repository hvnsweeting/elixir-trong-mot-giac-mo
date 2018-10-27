defmodule JsonAddPlug do
  import Plug.Conn
  require Logger

  use Plug.Builder

  plug Plug.Parsers, parsers: [:json], json_decoder: Jason

  def init(options), do: options

  def call(conn, _opts) do

    conn =  super(conn, [])
    IO.inspect conn.body_params
    %{"name" => name} = conn.body_params
    send_resp(conn, 201, Jason.encode!(%{message: name}))

  end
end
