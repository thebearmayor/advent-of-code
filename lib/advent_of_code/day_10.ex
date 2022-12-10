defmodule AdventOfCode.Day10 do
  def part1(input) do
    instructions =
      input
      |> parse()

    expand_instructions =
      instructions
      |> Enum.flat_map(&expand_instruction/1)

    {out, _} =
      expand_instructions
      |> Enum.flat_map_reduce(1, fn x, v -> {[x + v], x + v} end)

    [18, 58, 98, 138, 178, 218]
    |> Enum.map(fn x -> (x + 2) * Enum.at(out, x) end)
    |> IO.inspect()
    |> Enum.sum()
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&parse_line/1)
  end

  def parse_line(["noop"]), do: {:noop}
  def parse_line(["addx", count]), do: {:addx, String.to_integer(count)}

  def expand_instruction({:noop}), do: [0]
  def expand_instruction({:addx, n}), do: [0, n]

  def part2(input) do
    instructions =
      input
      |> parse()

    expand_instructions =
      instructions
      |> Enum.flat_map(&expand_instruction/1)

    {positions, _} =
      expand_instructions
      |> Enum.flat_map_reduce(1, fn x, v -> {[x + v], x + v} end)

    IO.puts("")

    Stream.zip([1 | positions], Stream.cycle(0..39))
    |> Stream.map(fn {pos, crt} -> if(crt in (pos - 1)..(pos + 1), do: "#", else: " ") end)
    |> Stream.chunk_every(40, 40)
    |> Stream.map(&Enum.join/1)
    |> Enum.join("\n")
    |> IO.puts()
  end
end
