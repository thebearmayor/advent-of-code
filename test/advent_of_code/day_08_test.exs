defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  # @tag :skip
  test "part1" do
    input = """
    30373
    25512
    65332
    33549
    35390
    """

    result = part1(input)

    assert result == 21
  end

  @tag :skip
  test "part2" do
    input = """
    30373
    25512
    65332
    33549
    35390
    """

    result = part2(input)

    assert result
  end
end
