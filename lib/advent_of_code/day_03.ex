defmodule AdventOfCode.Day03 do
  def part1(sacks) do
    sacks
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&split/1)
    |> Enum.map(&find_item/1)
    |> IO.inspect(label: "items: ")
    |> Enum.map(&score/1)
    |> IO.inspect(label: "scores: ")
    |> Enum.sum()
  end

  def split(sack) do
    mid = div(String.length(sack), 2)
    String.split_at(sack, mid)
  end

  def find_item({first, second}) do
    first = MapSet.new(String.graphemes(first))
    second = MapSet.new(String.graphemes(second))

    MapSet.intersection(first, second)
    |> Enum.at(0)
  end

  def score(item) do
    char = String.to_charlist(item) |> hd()

    if item == String.upcase(item) do
      char - ?A + 27
    else
      char - ?a + 1
    end
  end

  def part2(sacks) do
    sacks
    |> String.trim()
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(&find_badge/1)
    |> IO.inspect(label: "badges: ")
    |> Enum.map(&score/1)
    |> IO.inspect(label: "scores: ")
    |> Enum.sum()
  end

  def find_badge(group) do
    [first, second, third] = group |> Enum.map(&String.graphemes/1) |> Enum.map(&MapSet.new/1)

    MapSet.intersection(first, MapSet.intersection(second, third))
    |> Enum.at(0)
  end
end
