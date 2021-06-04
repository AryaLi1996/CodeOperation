defmodule OperationsTest do
  use ExUnit.Case
  doctest CodeOperations

  test "union" do
    memberA = fn(n) ->
      fruitList = ["apple banana", "apple banana orange", "orange kiwi pear", "kiwi banana", ""]
      n in fruitList
    end
    memberB = fn n ->
      nList = ["hello world", "foo bar", "apple banana"]
      n in nList
    end
    assert CodeOperations.union(memberA, memberB, "apple banana")
    refute CodeOperations.union(memberA, memberB, "arya li")
  end

  test "difference" do
    memberA = fn(n) ->
      fruitList = ["apple banana", "apple banana orange", "orange kiwi pear", "kiwi banana", ""]
      n in fruitList
    end
    memberB = fn n ->
      nList = ["hello world", "foo bar", "apple banana"]
      n in nList
    end
    assert CodeOperations.diff(memberA, memberB, "apple banana orange")
    refute CodeOperations.diff(memberA, memberB, "hello world")
  end

  test "sym-diff" do
    memberA = fn(n) ->
      fruitList = ["apple banana", "apple banana orange", "orange kiwi pear", "kiwi banana", ""]
      n in fruitList
    end
    memberB = fn n ->
      nList = ["hello world", "foo bar", "apple banana"]
      n in nList
    end
    assert CodeOperations.sym_diff(memberA, memberB, "hello world")
    refute CodeOperations.sym_diff(memberA, memberB, "apple banana")
  end

  test "con" do
    memberA = fn(n) ->
      fruitList = ["apple banana", "apple banana orange", "orange kiwi pear", "kiwi banana", ""]
      n in fruitList
    end
    memberB = fn n ->
      nList = ["hello world", "foo bar", "apple banana"]
      n in nList
    end#
    assert CodeOperations.con(memberA, memberB, "apple banana hello world")
    assert CodeOperations.con(memberA, memberB, "apple banana")
    refute CodeOperations.con(memberA, memberB, "apple banana orange")
    refute CodeOperations.con(memberA, memberB, "")
    refute CodeOperations.con(memberA, memberB, "hello world apple banana")
  end

  test "star" do
    memberA = fn(n) ->
      fruitList = ["apple banana", "apple banana orange", "orange kiwi pear", "kiwi banana", ""]
      n in fruitList
    end
    assert CodeOperations.star(memberA, "")
    assert CodeOperations.star(memberA, "apple banana apple banana orange orange kiwi pear")
    assert CodeOperations.star(memberA, "apple banana apple banana")
    assert CodeOperations.star(memberA, "kiwi banana orange kiwi pear apple banana")
    refute CodeOperations.star(memberA, "apple banana foo")
    refute CodeOperations.star(memberA, "apple banana foo apple banana")
    refute CodeOperations.star(memberA, "hello world")
  end

end
