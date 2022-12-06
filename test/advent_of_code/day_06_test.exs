defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  # @tag :skip
  test "part1" do
    assert part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert part1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert part1("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end

  @tag :skip
  test "part2" do
    assert part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
    assert part1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
    assert part1("nppdvjthqldpwncqszvftbrmjlhg") == 23
    assert part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
    assert part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
  end
end
