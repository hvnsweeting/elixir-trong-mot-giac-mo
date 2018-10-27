defmodule Len do
  def len([_|tail]) do
    1 + len(tail)
  end
  def len([]) do
    0
  end

  def len2(list) do
    if list == [] do
      0
    else
      [_|t] = list
      1 + len2(t)
    end
  end

  def main() do
    data = 1..10 |> Enum.to_list
    IO.puts (len(data) == len2(data))
    IO.puts len2(data)
  end
end
