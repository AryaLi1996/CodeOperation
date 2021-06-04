defmodule ComplexTest do
  @moduledoc false
  def main do
    modules_func()
  end

  def anonymous_func do
    list_concat = fn a, b -> a ++ b end
    IO.inspect list_concat.([1,2,3], [4,5,6])

    sum = fn a,b,c -> a + b + c end
    IO.puts "sum is: #{sum.(1, 2, 3) }"

    pair_tuple_to_list = fn {a, b} -> [a, b] end
    IO.inspect pair_tuple_to_list.({ 8, 7 }), charlists: :as_lists
  end

  def anonymous_func2 do
    {first, _} = IO.gets("first one:") |> Integer.parse
    {second, _} = IO.gets("second one:") |> Integer.parse
    {third, _} = IO.gets("third one:") |> Integer.parse

    fizzBuzz = fn a, b, c ->
      if a == 0 do
        if b == 0 do
          "FizzBuzz"
        else
          "Fizz"
        end
      else
        if b == 0 do
          "Buzz"
        else
          c
        end
      end
    end

    fizzBuzz2 = fn
     0, 0, _ -> "FizzBuzz"
     0, _, _ -> "Fizz"
     _, 0, _ -> "Buzz"
     _, _, n -> n
    end

    fizzBuzz4 = fn n ->
      fizzBuzz2.(rem(n,3), rem(n,5), n)
    end


    IO.puts "res for FizzBuzz1: #{fizzBuzz.(first, second, third)}"
    IO.puts "res for FizzBuzz2: #{fizzBuzz2.(first, second, third)}"
    IO.inspect {
      for n <- [10, 11, 12, 13, 14, 15, 16] do
        fizzBuzz4.(n)
      end}
  end

  def anonymous_func3 do
    fizzBuzz3 = fn a ->
      if rem(a, 3) == 0 do
        if rem(a, 5) == 0 do
          "FizzBuzz"
        else
          "Fizz"
        end
      else
        if rem(a, 5) == 0 do
          "Buzz"
        else
          a
        end
      end
    end

    IO.inspect {
      for n <- [10, 11, 12, 13, 14, 15, 16] do
        fizzBuzz3.(n)
      end}
  end

  def anonymous_func4 do
    num = 1
    res = ""
    prefix = fn prefix ->
      fn a ->
       "#{prefix} #{a}"
      end
    end


    IO.puts prefix.("Mrs").("Smith")
  end

  def anonymous_func5 do

    IO.inspect Enum.map [1,2,3,4], &(&1 + 2)
    Enum.each([1,2,3,4], &(IO.puts &1))

  end

  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: double(double(n))
  def sum(0), do: 0
  def sum(n) do
    n + sum(n - 1)
  end
  def gcd(x, 0), do: x
  def gcd(x, y) do
      gcd(y, rem(x,y))
  end
  def guess(x,x), do: x
  def guess(x, y) do
    first..last = y
    mid = first + div((last - first), 2)
    IO.puts "Is it #{mid}"
    if mid > x do
      guess(x, first..mid)
    else
      if mid == x do
        guess(x, mid)
      else
        guess(x, mid..last)
      end
    end
  end
  @doc """
  the answer is:
  def guess(actual, range = low..high) do
    guess = div(low + high, 2)
    IO.puts "Is is "
    _guess(actual, guess, range)
  end
  defp _guess(actual, guess, range = low..high)
    when actual < guess,
    do: guess(actual, low..guess - 1)
  defp _guess(actual, guess, range = low..high)
    when actual > guess
    do: guess(actual, guess + 1..high)
  defp _guess(actual, actual, _)
    do: actual
  end
  """

  def modules_func do
    f = 23.34556565
    s = String.split(to_string(f), ".")
    :io.format("~.2f~n", [f])
    System.get_env("HOME")
#    IO.puts mapsum.([1,2,3], &(&1 * &1))
  end
  def mapsum([], f), do: 0
  def mapsum([head | tail], f) do
    f.(head) + mapsum(tail, f)
  end

  def max([]) ,do: 0
  def max([head | tail]) do
    if head > max(tail) do
      head
    else
      max(tail)
    end
  end
  def caesar([], _), do: []
  def caesar([head | tail], n) do
    if head + n > ?z do
      nil
    else
      [head + n | caesar(tail, n)]
    end
  end

  def span(from , to) when from > to, do: []
  def span(from, to) do
    [from | span(from + 1, to)]
  end

  def all?([], _), do: true
  def all?([head|tail], fun) do
    fun.(head) and all?(tail, fun)
  end
  def each([], _), do: []
  def each([head| tail], fun) do
    [fun.(head) | each(tail, fun)]
  end

  def filter([], _), do: []
  def filter([head|tail], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

 def split(list, n) do
   _split(list, [], n)
  end
  defp _split([head|tail], front, n) when n > 0,
    do: _split(tail, [head|front], n - 1)
  defp _split([], front, _) do
    [Enum.reverse(front), []]
  end
  defp _split(tail, front, 0) do
    [Enum.reverse(front), tail]
  end

  def take(list, n) do
    List.first(split(list, n))
  end

  def flatten([head|tail]) do
    (_flatten(head,tail))
  end
  defp _flatten([head|tail], [head1|tail1]) do
    _flatten(head, tail) ++ _flatten(head1, tail1)
  end
  defp _flatten([], []), do: []
  defp _flatten(n, [head|tail]), do: [n] ++ _flatten(head, tail)
  defp _flatten([head|tail], n), do: _flatten(head, tail) ++ n
  defp _flatten(n, []), do: [n]
  defp _flatten([], n), do: [n]

  def flatten2(list) do
    _flatten2(list, [])
  end
  def _flatten2([],res), do: Enum.reverse(res)
  def _flatten2([[h|[]]|tail], res) do
    _flatten2([h|tail], res)
  end
  def _flatten2([[h|t]|tail], res) do
    _flatten2([h,t |tail], res)
  end
  def _flatten2([h|t], res) do
    _flatten(t, [res|h])
  end

  def is_prime(x) do
    range = span(2, x-1)
    res = Enum.all?(range, fn(n) -> rem(x, n) !=0 end)
    res
  end
  def prime(n) do
    range = span(2, n)
    res = filter(range, fn(n) -> is_prime(n) end)
    res
  end

  def orders_with_total(tax_rate, orders) do
      add_total(orders, tax_rate)
  end

  def add_total([], _), do: []
  def add_total([head|tail],tax_rates) do
    office = head[:ship_to]
    tax = case tax_rates[office] do
      nil -> 0
      _ -> tax_rates[office]
    end
    net_amount = head[:net_amount]
    new_order = head ++ [total_amount: net_amount + tax * net_amount]
    [new_order | add_total(tail, tax_rates)]
  end




end
