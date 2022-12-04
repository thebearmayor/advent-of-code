defmodule AdventOfCode.Day01 do
  def part1(elves) do
    elves
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&calories/1)
    |> Enum.max()
  end

  def part2(elves) do
    elves
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&calories/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def calories(elf) do
    elf
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
