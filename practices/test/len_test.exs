defmodule LenTest do
  use ExUnit.Case

  test "len of [1,2,3] is 3" do
    assert Len.len([1,2,3]) == 3
  end
  test "len2 of [1,2,3] is 3" do
    assert Len.len2([1,2,3]) == 3
  end
end
