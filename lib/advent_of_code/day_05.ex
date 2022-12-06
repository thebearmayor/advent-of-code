defmodule AdventOfCode.Day05 do
  def part1(input) do
    [init, steps] =
      input
      |> String.split("\n\n")

    stacks = parse_init(init)

    stacks =
      steps
      |> String.trim()
      |> String.split("\n")
      |> Enum.reduce(stacks, fn step, stacks ->
        IO.inspect(step)

        [_, {count, _}, _, {from, _}, _, {to, _}] =
          String.split(step) |> Enum.map(&Integer.parse/1)

        move(stacks, count, from, to)
      end)

    1..map_size(stacks)
    |> Enum.map(fn i -> :queue.peek(stacks[i]) |> elem(1) end)
    |> Enum.join()
  end

  def parse_init(init) do
    lines = init |> String.split("\n") |> Enum.reverse()

    pre =
      lines
      |> Enum.drop(1)
      |> IO.inspect()
      |> Enum.map(fn ln -> ln |> String.graphemes() |> Enum.drop(1) |> Enum.take_every(4) end)
      |> IO.inspect(label: "pretranspose")

    Enum.zip_with(pre, &Function.identity/1)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(fn s -> Enum.drop_while(s, fn elem -> elem == " " end) end)
    |> IO.inspect(label: "posttranspose")
    |> Enum.map(&:queue.from_list/1)
    |> then(fn x -> Enum.zip(1..9, x) end)
    |> Map.new()
  end

  def move(stacks, count, from, to) do
    0..(count - 1)
    |> Enum.reduce(stacks, fn _, stacks -> move_one(stacks, from, to) end)
    |> IO.inspect(label: "move")
  end

  def move_one(stacks, from, to) do
    {{:value, v}, stacks} = get_and_update_in(stacks[from], &:queue.out/1)
    stacks = update_in(stacks[to], fn q -> :queue.in_r(v, q) end)
    stacks
  end

  def part2(input) do
    [init, steps] =
      input
      |> String.split("\n\n")

    stacks = parse_init(init)

    stacks =
      steps
      |> String.trim()
      |> String.split("\n")
      |> Enum.reduce(stacks, fn step, stacks ->
        [_, {count, _}, _, {from, _}, _, {to, _}] =
          String.split(step) |> Enum.map(&Integer.parse/1)

        move_bulk(stacks, count, from, to)
      end)

    1..map_size(stacks)
    |> Enum.map(fn i -> :queue.peek(stacks[i]) |> elem(1) end)
    |> Enum.join()
  end

  def move_bulk(stacks, count, from, to), do: move_bulk(stacks, count, from, to, [])

  def move_bulk(stacks, 0, _from, _to, []), do: stacks

  def move_bulk(stacks, 0, from, to, [el | temp]) do
    update_in(stacks[to], fn q -> :queue.in_r(el, q) end)
    |> move_bulk(0, from, to, temp)
  end

  def move_bulk(stacks, count, from, to, temp) do
    {{:value, v}, stacks} = get_and_update_in(stacks[from], &:queue.out/1)
    temp = [v | temp]
    move_bulk(stacks, count - 1, from, to, temp)
  end
end
