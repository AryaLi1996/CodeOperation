defmodule CodeOperations do
  @moduledoc false

  def union(memberA, memberB, str) do
    memberA.(str) || memberB.(str)
  end

  def diff(memberA, memberB, str) do
    memberA.(str) and (!memberB.(str))
  end

  def sym_diff(memberA, memberB, str) do
    (memberA.(str) || memberB.(str)) and !(memberA.(str) and memberB.(str))
  end

  def concat_string([]), do: " "
  def concat_string([""]), do: ""
  def concat_string([head|tail])do
    if head != "" do
      head <> " " <> concat_string(tail)
    else
       concat_string(tail)
   end
  end

  def con(memberA, memberB, str) do
    str_list = [""] ++ String.split(str, " ")
    range = 1..length(str_list)
    results = for n <- range do
      candidates = Enum.take(str_list, n)
      candidates_str = String.replace(concat_string(candidates), "  ", "")
      if memberA.(candidates_str) do
        new_list = Enum.drop(str_list, n)
        memberB.(String.replace(concat_string(new_list), "  ", ""))
      end
    end
    Enum.any?(results, fn(n) -> n == true end)
  end

  def star(memberA, str) do
    if str == "" do
      true
    else
      str_list = String.split(str, " ")
      range = 1..length(str_list)+ 1
      results = findA(str_list, memberA, range)
      Enum.all?(results, fn n -> n == true end)
    end
  end


  def findA(list,memberA, low..high) do
    _findA(list, memberA, low..high, "")
  end
  defp _findA(_, _, low..high, _) when low == high, do: []
  defp _findA(list, memberA, low..high, last_str) do
    candidates = Enum.take(list, low)
    candidates_str = String.replace(concat_string(candidates), "  ", "")
    if memberA.(candidates_str) do
      new_list = Enum.drop(list, low)
      [true | _findA(new_list, memberA, 1..high - low, candidates_str)]
    else
      if memberA.(last_str <> " " <> candidates_str) do
        new_list = Enum.drop(list, low)
        [true | _findA(new_list, memberA, 1..high - low, last_str <> " " <> List.last(candidates))]
      else
        if low == high - 1 do
          [false]
        else
          _findA(list, memberA, low+1..high, last_str <> " " <> List.last(candidates))
        end
      end
    end
  end


end
