defmodule PracticesTest do
  use ExUnit.Case
  doctest Practices

  test "greets the world" do
    assert Practices.hello() == :world
  end
end
