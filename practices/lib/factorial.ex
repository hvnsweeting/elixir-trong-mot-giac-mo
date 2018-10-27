defmodule Factorial do
  def fact(n) do
    if n == 0 do
      1
    else
      n * fact(n-1)
    end
  end
end
