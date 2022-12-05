defmodule AdventOfCode.Day04 do
  def part1(pairs) do
    pairs
    |> String.trim()
    |> String.split("\n")
    |> Enum.count(&overlap?/1)
  end

  def overlap?(pair) do
    [s1, e1, s2, e2] = String.split(pair, ["-", ","]) |> Enum.map(&String.to_integer/1)
    res = (s1 <= s2 and e1 >= e2) or (s2 <= s1 and e2 >= e1)

    if res do
      IO.puts(pair)
    end

    res
  end

  def part2(pairs) do
    pairs
    |> String.trim()
    |> String.split("\n")
    |> Enum.count(&overlap2?/1)
  end

  def overlap2?(pair) do
    [s1, e1, s2, e2] = String.split(pair, ["-", ","]) |> Enum.map(&String.to_integer/1)
    res = (s1 <= s2 and e1 >= s2) or (s2 <= s1 and e2 >= s1)

    if res do
      IO.puts(pair)
    end

    res
  end
end
