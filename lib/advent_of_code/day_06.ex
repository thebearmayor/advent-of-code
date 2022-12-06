defmodule AdventOfCode.Day06 do
  def part1(signal) do
    detect(signal, 4)
  end

  def detect(signal, window_size) do
    window_size +
      (signal
       |> String.trim()
       |> String.graphemes()
       |> Enum.chunk_every(window_size, 1)
       |> Enum.find_index(fn grp -> length(Enum.uniq(grp)) == length(grp) end))
  end

  def part2(signal) do
    detect(signal, 14)
  end
end
