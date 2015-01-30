defmodule SicpInElixirTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "sum of squares for max two numbers" do
    assert SicpInElixir.f(2,3,4) == (3 * 3) + (4 * 4)
  end
end

defmodule SicpInElixirTest.FastExpt do
  use ExUnit.Case

  test "exponent works" do
    import SicpInElixir.FastExpt, only: [calc: 2]
    assert calc(2, 3) == 8
  end
end
