defmodule MyString do
  @moduledoc false
  def main do
#    IO.inspect ?0..?9, charlists: :as_list
    IO.inspect calculate("34  - 56")
end
  def printable_ascii(s), do: Enum.all?(s, fn(n) -> n in  ? ..?~ end)

  def anagram(s1, s2), do: Enum.sort(s1) == Enum.sort(s2)

  def calculate(expression) do
    {n1, rest} = Integer.parse(expression)
    rest = get_rid_space(rest)
#      {a, b} = String.split_at(rest, 1)
    {opt, rest} = parse_opt(rest)
#    rest = skip_space(rest)
    {n2, _} = Integer.parse(rest)
    opt.(n1, n2)
  end
#  def skip_space(res) do
#    if String.contains?(res," ") do
#      {_, r} = String.split_at(res, 1)
#      r
#    else
#      res
#    end
#  end

  def get_rid_space(res) do
    String.replace(res, " ", "")
  end
  def parse_opt(res) do
    if String.contains?(res,"+") do
      {_, r} = String.split_at(res, 1)
      {fn(n1, n2) -> n1 + n2 end, r}
    else if String.contains?(res,"-") do
      {_, r} = String.split_at(res, 1)
      {fn(n1, n2) -> n1 - n2 end, r}
    else if String.contains?(res,"*") do
      {_, r} = String.split_at(res, 1)
      {fn(n1, n2) -> n1 * n2 end, r}
    else if String.contains?(res,"/") do
      {_, r} = String.split_at(res, 1)
      {fn(n1, n2) -> div(n1, n2) end, r}
      end
      end
      end
    end
  end

  def print_space(0), do: nil
  def print_space(n) do
    IO.write " "
    print_space(n - 1)
  end
  def center(dps) do
    lengths = Enum.map(dps, fn(dp) -> String.length(dp)end)
    maxLen = List.last(Enum.sort(lengths))
    Enum.each dps, fn n ->
      spaces = div(maxLen- String.length(n),2)
      print_space(spaces)
      IO.puts n
      end
  end


  def concat_string([head|tail])do
    head <> ". " <> concat_string(tail)
  end
  def concat_string(t), do: ""
  def capitalize_sentences(str) do
    str_list = List.delete(String.split(str, ". "), "")
    caped = for s <- str_list do
      String.capitalize(s)
    end
    concat_string(caped)
  end


  def fizzBuzz(a) do
    cond do
      rem(a, 3) ==0 and rem(a, 5) == 0 -> IO.puts "FizzBuzz"
      rem(a, 3) == 0 -> IO.puts "Fizz"
      rem(a, 5) == 0 -> IO.puts "Buzz"
      true -> IO.puts(a)
    end
  end

  def fizzBuzz2(a) when rem(a, 3) == 0 and rem(a, 5) == 0 do
    IO.puts "FizzBuzz"
  end
  def fizzBuzz2(a) when rem(a, 3) == 0 do
    IO.puts "Fizz"
  end
  def fizzBuzz2(a) when rem(a, 5) == 0 do
    IO.puts "Buzz"
  end
  def fizzBuzz2(a) do
    IO.puts a
  end

  def ok!({:ok, data}), do: data
  def ok!({error_type, error_msg}), do: raise("#{error_type}: #{error_msg}")

  def excep do
    err = try do
      MyString.ok!({:a, 12})
    rescue
      x -> IO.puts"Error"
           IO.puts x.message
    end
    IO.puts err
  end

  def filter2([],_), do: []
  def filter2([head|tail], fun) do
    if fun.(head) do
      [head | filter2(tail, fun)]
    else
      filter2(tail, fun)
    end
  end

  def split(_, 0), do: []
  def split([head|tail],n) do
    [head | split(tail, n - 1)]
  end

  def flatten(list) do
     _flatten(list)
  end
  defp _flatten([]), do: []
#  defp _flatten(n), do: [n]
  defp _flatten([[h]]), do: _flatten([h])
  defp _flatten([[h|t]|tail]) do
   [h] ++ _flatten(t) ++ _flatten(tail)
  end
  defp _flatten([[h | []] | tail]) do
   [h] ++ _flatten(tail)
  end
  defp _flatten([head| tail]) do
    [head] ++ _flatten(tail)
  end

  def

end

