defmodule AdventOfCode.Day02 do
  def part1(rounds) do
    rounds
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def score(round) do
    [theirs, mine] = String.split(round) |> Enum.map(&shape/1)
    score_outcome(theirs, mine) + score_shape(mine)
  end

  def shape(symbol) do
    map = %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors
    }

    map[symbol]
  end

  def score_outcome(:rock, :paper), do: 6
  def score_outcome(:rock, :scissors), do: 0
  def score_outcome(:paper, :scissors), do: 6
  def score_outcome(:paper, :rock), do: 0
  def score_outcome(:scissors, :rock), do: 6
  def score_outcome(:scissors, :paper), do: 0
  def score_outcome(_, _), do: 3

  def score_outcome(:win), do: 6
  def score_outcome(:lose), do: 0
  def score_outcome(_), do: 3

  def score_shape(shape) do
    map = %{:rock => 1, :paper => 2, :scissors => 3}
    map[shape]
  end

  def part2(rounds) do
    rounds
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&score2/1)
    |> Enum.sum()
  end

  def score2(round) do
    [theirs, outcome] = String.split(round) |> Enum.map(&to_symbol/1)
    mine = choose(theirs, outcome)
    score_outcome(outcome) + score_shape(mine)
  end

  def to_symbol(symbol) do
    map = %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :lose,
      "Y" => :draw,
      "Z" => :win
    }

    map[symbol]
  end

  def choose(:rock, :win), do: :paper
  def choose(:rock, :lose), do: :scissors
  def choose(:paper, :win), do: :scissors
  def choose(:paper, :lose), do: :rock
  def choose(:scissors, :win), do: :rock
  def choose(:scissors, :lose), do: :paper
  def choose(theirs, _), do: theirs
end
