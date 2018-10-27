defmodule FactTest do
  use ExUnit.Case

  test "factorial of 5 is 120" do
    assert Factorial.fact(5) == 120
  end
  test "factorial of 20 is 120" do
    assert Factorial.fact(20) == 2432902008176640000
  end
end
