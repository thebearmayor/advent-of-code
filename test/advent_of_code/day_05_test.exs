defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  @tag :skip
  test "part1" do
    input = """
        [D]    .
    [N] [C]    .
    [Z] [M] [P].
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    result = part1(input)

    assert result == "CMZ"
  end

  # @tag :skip
  test "part2" do
    input = """
        [D]    .
    [N] [C]    .
    [Z] [M] [P].
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    result = part2(input)

    assert result == "MCD"
  end
end
