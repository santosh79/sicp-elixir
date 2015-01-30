"""
The get_breakdown expects an integer amount and a list of
coins. It then tries to break change for the amount using the coins.
It returns the number of ways change can be given.

Example
    
    Coins.get_breakdown 100, [1] == 1

"""
defmodule Coins do
  def get_breakdown(0, _), do: 1
  def get_breakdown(amount, _) when amount < 0, do: 0
  def get_breakdown(_, []), do: 0
  def get_breakdown(amount, l = [first_coin|t]) do
    get_breakdown(amount, t) + get_breakdown(amount - first_coin, l)
  end
end

