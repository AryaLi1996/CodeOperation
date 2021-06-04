defmodule ElixirTest.Firsttest do
  @moduledoc false
  def main do
#    name = IO.gets("what is your name? ") |> String.trim
#    IO.puts "Hello #{name}"
    do_concurrency()
  end

  def data_stuff do
#    my_int = 3
    IO.puts "Atom #{is_atom(:"New York")}"
  end

  def do_stuffString do
    my_str = "my Sentence"
    IO.puts "Length: #{String.length(my_str)}"
    my_longStr = my_str <> " is longer"
    IO.puts "Length: #{String.length(my_longStr)}"
    IO.puts "Equals: #{"Egg" === "egg"}"
    IO.puts "My? : #{String.contains?(my_str, "my")}"
    IO.puts "first: #{String.first(my_str)}"
    IO.puts "index 8 : #{String.at(my_str, 8)}"
    IO.puts "subString: #{String.slice(my_str, 3, 4)}" # start from index 3, get 4 characters

    IO.inspect String.split(my_longStr, " ")
    IO.puts String.reverse(my_longStr)
    IO.puts String.upcase(my_longStr)
    IO.puts String.downcase(my_longStr)
    IO.puts String.capitalize(my_longStr) # result: My sentence is longer
    4 * 10 |> IO.puts
  end

  def do_stuffCalculate do
    IO.puts "5 + 4: #{5 + 4}"
    IO.puts "5 / 4: #{5/4}" #result is a float
    IO.puts "5 div 4: #{div(5, 4)}" # result is 1
    IO.puts "5 rem 4: #{rem(5, 4)}" #same as %
  end

  def do_stuffEqual do
    # == compare the value, === compare the value and the type
    IO.puts "4 == 4.0: #{4 == 4.0}"
    IO.puts "4 === 4.0: #{4 ===4.0}"
    IO.puts "4 != 4.0: #{4 != 4.0}"
    IO.puts "4 !== 4.0: #{4 !== 4.0}"
  end

  def do_logical do
    {age, _} = IO.gets("how old are you ?") |> Integer.parse
    name = IO.gets("what is your name? ") |> String.trim
#    {age, _} = IO.gets("enter age: ") |> Integer.parse
#    age = 10
    IO.puts "age is #{age}"
    IO.puts "age is greater: #{age >= 16 and age <= 18}"
    IO.puts "age is greater: #{age >= 16 and age >= 18}"
    IO.puts "age is greater: #{age >= 16 or age >= 18}"

    if age >= 18 do
      IO.puts "can"
    else
      IO.puts "can't"
    end

    if age == 16 do
      IO.puts"is "
    else
      IO.puts "not"
    end

    unless age === 18 do
      IO.puts "is not 18"
    else
      IO.puts " is 18"
    end

    cond do
      age >= 18 -> IO.puts "you can vote"
      age >= 16 -> IO.puts "you can drive"
      age >= 14 -> IO.puts "you can wait"

      true -> IO.puts "Default"
    end

    case age do
      10 -> IO.puts "is 10"
      18 -> IO.puts " is 18"
      _ -> IO.puts "default"
    end

    IO.puts "Ternary: #{if age >= 18 , do: "can vode", else: "cannot"}"
    IO.puts "Ternary2: #{if name === "arya", do: "hello you", else: "I don't know you"}"
  end

  def do_tuple do
    my_tuple = {100, 10, :abc}

    IO.puts "is tuple #{is_tuple(my_tuple)}"

    my_tuple2 = Tuple.append(my_tuple, 25)

    IO.puts "age: #{elem(my_tuple2, 3)}"

    IO.puts "Size: #{tuple_size(my_tuple2)}"

    my_tuple3 = Tuple.delete_at(my_tuple2, 0)
    my_tuple4 = Tuple.insert_at(my_tuple3, 0, 1999)
    many_zero = Tuple.duplicate(0, 5)
    IO.puts "duplicate is: #{elem(many_zero, 0)}"

    {weight, age, name} = {1000, 200, "pig"}
    IO.puts "name is #{name}"
  end

  def do_list do
    list1 = [1, 2, 3]
    list2 = [4,5,6]

    bigger_list = list1 ++ list2
    bigger_list2 = bigger_list ++ [10]

    IO.puts "if contain 10: #{10 in bigger_list2}"
    IO.puts "if contains 100: #{100 in bigger_list2}"

    [head | tail] = bigger_list2

    IO.puts "head is : #{head}"
    IO.puts "tail"
    IO.write "tail: "
    IO.inspect tail

    IO.inspect [97, 98]
    IO.inspect [97, 98], charlists: :as_lists
#    char_list = [97, 98]
#    IO.puts "first in charList: #{elem(char_list, 0)}"
    words = ["this", "is", "a", "test"]
    Enum.each words, fn word ->
      IO.puts word
    end
    Enum.each tail, fn i ->
      IO.puts i
    end

    do_displayRecurse(List.insert_at(words, 0, "hello"))

    IO.puts List.first(words)
    IO.puts List.last(words)

    key_list = [name: "arya", age: 26]
#    do_displayRecurse(key_list)
  end

  def do_maps do
    name_map = %{"first" => "tianshu", "last" => "li", "nick" => "arya"}
    IO.puts "my first name is : #{name_map["first"]}"
    name_map2 =  %{first: "tianshu", last: "li", nick: "arya"}
    IO.puts "my last name is: #{name_map2.last}"

    added_name = Dict.put_new(name_map, "other", "random")
  end

  def do_patternMatching do
#    {age, _} = IO.gets("how old are you ?") |> Integer.parse# the value of _ is "\n"
    [num1, num2] = [1, 2]
    ^num1 = 1
    #^ in patternMatching:
    # It pins the variable on its value and prevent any assignment to this variable when using pattern matching.
    [num3, [_, num4]] = [3, [4, 5]]
    IO.puts "values of first pattern: #{num1}, and #{num2}"
    IO.puts "values of second patten: #{num3}, and #{num4}"
  end

  def do_anonymousFun do
    get_sum = fn (x, y) -> x + y end

    get_sum2 = &(&1 + &2)

    opt_sum = fn
      {x, y}-> IO.puts "#{x} + #{y} = #{x + y}"
      {x, y, z} -> IO.puts "#{x} + #{y} + #{z} = #{x + y + z}"
    end

    IO.puts "5 + 5: #{get_sum.(5, 5)}"
    IO.puts "6 + 7: #{get_sum2.(6, 7)}"

    IO.puts "try opt sum1: #{opt_sum.({5, 6})}"
    IO.puts "try opt sum2: #{opt_sum.({6,7,8})}"
  end

  def do_recurseAndLoop do
    # use recure to loop
  end

  def do_enum do
    IO.puts "Even list: #{Enum.all?([1,2,3], fn(n) -> rem(n, 2) == 0 end)}"
    IO.puts "Even in a list: #{Enum.any?([1,2,3], fn(n) -> rem(n, 2) == 0 end)}"
    Enum.each([1,2,3], fn elem ->
       if rem(elem, 2) == 0 do
          IO.puts "this is even: #{elem}"
        else
          IO.puts "this is not even #{elem}"
         end
     end)
    dbl_list = Enum.map([1,2,3], fn(n) -> n * 2 end)
    IO.inspect dbl_list
    sum_val = Enum.reduce([1,2,3], fn(n, sum) -> n + sum end)
    val2 = Enum.reduce([4,5,6], fn(n, v) ->
          if rem(n, 2) == 0 do
            n * v
          else v
            end
          end)

    IO.puts "sum is : #{sum_val}"
    IO.puts "val2 is :#{val2}"
    IO.inspect Enum.uniq([1,2,3,3,3,3])
  end

  def do_for do
    dbl_list = for n <- [1,2,3] do n * 2 end
    even_list = for n <- [1,2,3,4,5,6], rem(n, 2) == 0 do n end
    less_list = for n <- [1,2,4,6,79,9], n >=9 do n end
    IO.inspect dbl_list
    IO.inspect even_list
    IO.inspect less_list, charlists: :as_lists
  end

  def do_exception do
    err = try do
      5/0
      rescue
        ArithmeticError -> "cannot divide by zero"
    end
    IO.puts err
  end

  def do_concurrency do
    # sharing time, working at the same time, rowing turns
    spawn(fn() -> loop(50, 1) end)
    spawn(fn() -> loop(100, 50) end)

    send(self(), {:last, "li"})

    receive do
      {:first, name} -> IO.puts "this is your first name: #{name}"
      {:last, name} -> IO.puts "this is your second name: #{name}"
      {:nick, name} -> IO.puts "this is your nick name: #{name}"
      after
      500 -> IO.puts "Time out"
    end
  end

  def loop(0, _), do: nil
  def loop(max, min) do
    if max < min do
      loop(0, min)
    else
      IO.puts "Num: #{max}"
      loop(max - 1, min)
    end
  end
  def do_displayRecurse([word | words]) do
    IO.puts word
    do_displayRecurse(words)
  end

  def do_displayRecurse([]), do: Nil

end