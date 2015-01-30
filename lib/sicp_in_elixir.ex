defmodule SicpInElixir do

  def inc(x), do: x + 1
  def dec(x), do: x - 1

  def piano_add(0, y), do: y
  def piano_add(x, y) do
    piano_add dec(x), inc(y)
  end

  def fact_recur(1), do: 1
  def fact_recur(n) when n > 0, do: n * fact_recur(n - 1)
  def fact(n) when n > 0, do: fact(n, 1)
  defp fact(1, acc), do: acc
  defp fact(n, acc) when n > 1 do
    fact (n-1), (acc * n)
  end

  def square(x),  do: x * x
  def sums_match(a, b, c), do: ((a + b) === c)

  def sum_of_squares(a, b), do: square(a) + square(b)


  def f(l = [_,_]) do
    Enum.max(l) |> square
  end

  def f(l = [_,_,_]) do
    square(Enum.max(l)) + f(l -- [Enum.max(l)])
  end

  def f(a, b, c),  do: f([a, b, c])

  # def test_order_evaluation(0, b), do: 0
  # def test_order_evaluation(a, b) do
  #   apply b, []
  # end

  def sqrt_root(number) when number > 0 do
    sqrt_root(number, 1)
  end

  def sqrt_root(number, guess) when number > 0 do
    if good_enough?(number, guess) do
      guess
    else
      sqrt_root number, improved_guess(number, guess)
    end
  end

  defp improved_guess(number, guess) do
    quotient = number / guess
    avg(quotient, guess)
  end

  defp avg(a, b), do: (a + b)/2

  defp good_enough?(number, guess) do
    abs(square(guess) - number) < 0.001
  end
end

"""
This module finds the number of ways to break an amount, given the coins
we can use.
The basic idea is that given an amount A and the types of coins [B, C, D],
the number of ways we can break A given those coins is:
 - The number of ways we can break A with just [C,D]
 - The number of ways we can break A using B
    - This is basically the number of ways we can break (A - B) using [B, C, D]
    Since when we add back B to (A - B) we get A.
"""
defmodule SicpInElixir.Change do
  def change(_, []), do: 0
  def change(amount, coins) when amount > 0, do: get_change(amount, coins)

  defp get_change(0, _), do: 1
  defp get_change(amount, _) when amount < 0, do: 0
  defp get_change(_, []), do: 0
  defp get_change(amount, coins = [first_coin|rest]) do
    get_change(amount, rest) + get_change(amount - first_coin, coins)
  end
end

#  0 0 0 1 1 0 0 0 
#   0 0 1 2 1 0 0
#    0 1 3 3 1 0
#     1 4 6 4 1
#      5 X X 5
#       F T F
#        35 35
#         70
defmodule SicpInElixir.PascalsTriangle do
  def generate_triangle(number_of_rows) do
    row = tack_on_zeros [1]
    pascal_rows = get_row 0, number_of_rows, [row]
    print_rows pascal_rows
  end

  defp tack_on_zeros(row) do
    [0] ++ row ++ [0]
  end

  def get_row(stop, stop, row_acc), do: :lists.reverse(row_acc)
  def get_row(start, stop, row_acc = [row|_rest]) do
    next_row = get_row tack_on_zeros(row), []
    get_row (start + 1), stop, [next_row|row_acc]
  end

  def get_row([_first], acc), do: :lists.reverse(acc)
  def get_row([first, second|rest], acc) do
    get_row [second|rest], [(first + second)|acc]
  end

  defp print_rows(rows) do
    rows |>
    Enum.each(fn(row) ->
      IO.puts "#{inspect row}"
    end)
  end
end

defmodule SicpInElixir.FastExpt do
  import SicpInElixir, only: [square: 1]

  def calc(_, 0), do: 1
  def calc(b, n) do
    if even?(n) do
      square calc(b, div(n, 2))
    else
      b * calc(b, n - 1)
    else
    end
  end

  defp even?(n), do: rem(n, 2) == 0
end

defmodule SicpInElixir.Exercises do
  def one_dot_one_one_iter(n) when n < 3, do: n
  def one_dot_one_one_iter(n) when n >= 3 do
    one_dot_one_one_iter(3, n, 2, 1, 0)
  end

  defp one_dot_one_one_iter(n, n, acc_one, acc_two, acc_three) do
    acc_one + 2 * acc_two + 3 * acc_three
  end

  defp one_dot_one_one_iter(start, n, acc_one, acc_two, acc_three) do
    new_one = acc_one + 2 * acc_two + 3 * acc_three
    one_dot_one_one_iter (start + 1), n, new_one, acc_one, acc_two
  end

  def one_dot_one_one(n) when n < 3, do: n
  def one_dot_one_one(n) when n >= 3 do
    one_dot_one_one(n - 1) + 2 * one_dot_one_one(n - 2) + 3 * one_dot_one_one(n - 3)
  end
end

