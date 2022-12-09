defmodule AdventOfCode.Day08 do
  def part1(input) do
    {:ok, _} = Agent.start_link(fn -> Map.new() end, name: Trees)
    {:ok, _} = Agent.start_link(fn -> MapSet.new() end, name: VisibleTrees)
    {rows, cols} = parse(input)

    for(row <- 0..rows, do: for(col <- 0..cols, do: {row, col}))
    |> Enum.each(&visible/1)

    for(row <- 0..rows, do: for(col <- cols..0//-1, do: {row, col}))
    |> Enum.each(&visible/1)

    for(col <- 0..cols, do: for(row <- 0..rows, do: {row, col}))
    |> Enum.each(&visible/1)

    for(col <- 0..cols, do: for(row <- rows..0//-1, do: {row, col}))
    |> Enum.each(&visible/1)

    Agent.get(VisibleTrees, fn state -> MapSet.size(state) end)
  end

  def parse(input) do
    lines =
      input
      |> String.trim()
      |> String.split("\n")

    rows = length(lines) - 1
    Agent.update(Trees, fn state -> state |> Map.put(:rows, rows) end)
    cols = length(hd(lines) |> String.trim() |> String.graphemes()) - 1
    Agent.update(Trees, fn state -> state |> Map.put(:cols, cols) end)

    lines
    |> Enum.with_index()
    |> Enum.flat_map(&parse_line/1)
    |> Enum.each(fn {tree, height} ->
      Agent.update(Trees, fn state -> state |> Map.put(tree, height) end)
    end)

    {rows, cols}
  end

  def parse_line({line, line_idx}) do
    line
    |> String.trim()
    |> String.graphemes()
    |> Enum.with_index(fn char, idx -> {{idx, line_idx}, char} end)
  end

  def visible(trees) do
    trees
    |> Enum.reduce(-1, &reducer/2)

    {:ok}
  end

  def reducer(tree, max) do
    height = Agent.get(Trees, fn state -> state |> Map.get(tree) end)

    if height > max do
      Agent.update(VisibleTrees, fn state -> state |> MapSet.put(tree) end)
      height
    else
      max
    end
  end

  def part2(input) do
    {:ok, _} = Agent.start_link(fn -> Map.new() end, name: Trees)
    {:ok, _} = Agent.start_link(fn -> Map.new() end, name: Scores)
    {rows, cols} = parse(input)

    for(row <- 0..rows, do: for(col <- 0..cols, do: {row, col}))
    |> Enum.each(&visible2/1)

    for(row <- 0..rows, do: for(col <- cols..0//-1, do: {row, col}))
    |> Enum.each(&visible2/1)

    for(col <- 0..cols, do: for(row <- 0..rows, do: {row, col}))
    |> Enum.each(&visible2/1)

    for(col <- 0..cols, do: for(row <- rows..0//-1, do: {row, col}))
    |> Enum.each(&visible2/1)

    Agent.get(VisibleTrees, fn state -> MapSet.size(state) end)
  end

  def visible2(trees) do
  end

  def reducer2(tree, max, dist_to_max) do
  end
end
