defmodule AdventOfCode.Day09 do
  def part1(input) do
    {:ok, _} = Visited.start_link()
    {:ok, _} = RopeAgent.start_link()
    moves = parse(input)

    moves
    |> IO.inspect(label: "moves")
    |> Enum.each(&RopeAgent.move/1)

    Visited.size()
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    [dir, count] = line |> String.split()
    {dir, String.to_integer(count)}
  end

  def part2(_args) do
  end
end

defmodule Visited do
  use Agent

  def start_link() do
    Agent.start_link(fn -> MapSet.new() end, name: __MODULE__)
  end

  def visit(cell) do
    Agent.update(__MODULE__, fn state -> MapSet.put(state, cell) end)
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end

  def size() do
    Agent.get(__MODULE__, &MapSet.size(&1))
  end
end

defmodule Rope do
  defstruct head: {0, 0}, tail: {0, 0}
end

defmodule RopeAgent do
  use Agent

  def start_link() do
    res = Agent.start_link(fn -> %Rope{} end, name: __MODULE__)
    Visited.visit(tail())
    res
  end

  def head() do
    Agent.get(__MODULE__, & &1.head)
  end

  def tail() do
    Agent.get(__MODULE__, & &1.tail)
  end

  def move({dir, count}) do
    1..count
    |> Enum.each(fn _ ->
      move_head(dir)
      move_tail()
    end)

    IO.inspect({dir, count}, label: "move")
    IO.inspect(head(), label: "head")
    IO.inspect(tail(), label: "tail")
  end

  defp move_head({dy, dx}) do
    Agent.update(__MODULE__, fn rope ->
      Map.update!(rope, :head, &{elem(&1, 0) + dy, elem(&1, 1) + dx})
    end)
  end

  defp move_head("R"), do: move_head({0, 1})
  defp move_head("L"), do: move_head({0, -1})
  defp move_head("U"), do: move_head({1, 0})
  defp move_head("D"), do: move_head({-1, 0})

  defp move_tail() do
    {hy, hx} = head()
    {ty, tx} = tail()

    dy = hy - ty
    dx = hx - tx

    if abs(dy) > 1 or abs(dx) > 1 do
      move_tail({unit(dy), unit(dx)})
    end
  end

  defp move_tail({dy, dx}) do
    Agent.update(__MODULE__, fn rope ->
      rope = Map.update!(rope, :tail, &{elem(&1, 0) + dy, elem(&1, 1) + dx})
      Visited.visit(rope.tail)
      # IO.inspect(Visited.get(), label: "visited")
      rope
    end)
  end

  defp unit(0), do: 0
  defp unit(n) when n < 0, do: -1
  defp unit(_), do: 1
end
