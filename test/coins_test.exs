defmodule CoinsTest do
  use ExUnit.Case

  test "with just one type of coins" do
    assert Coins.get_breakdown(100, [1]) == 1
  end

  test "normal way" do
    assert Coins.get_breakdown(100, [1, 5, 10, 25]) == 242
  end

  test "with no way of breaking down" do
    assert Coins.get_breakdown(100, [3]) == 0
  end
end
