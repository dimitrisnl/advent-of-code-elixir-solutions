defmodule AdventOfCode.Year2024.Day1.Solution do
  @moduledoc """
  Solution for day 1
  """
  def part1(input) do
    {list1, list2} = parse(input)

    sorted_list1 = Enum.sort(list1)
    sorted_list2 = Enum.sort(list2)

    Enum.zip(sorted_list1, sorted_list2)
    |> Enum.map(fn {x, y} -> abs(y - x) end)
    |> Enum.sum()
  end

  def part2(input) do
    {list1, list2} = parse(input)

    list2_frequencies = Enum.frequencies(list2)

    Enum.reduce(list1, 0, fn x, acc ->
      case Map.get(list2_frequencies, x, 0) do
        count when count > 0 -> acc + count * x
        _ -> acc
      end
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn row, {list1, list2} ->
      [item1, item2] = row |> String.split("   ") |> Enum.map(&String.to_integer/1)
      {[item1 | list1], [item2 | list2]}
    end)
  end
end
