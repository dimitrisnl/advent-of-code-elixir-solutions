defmodule AdventOfCode.Year2024.Day2.Solution do
  @moduledoc """
  Solution for day 2
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp solve_part1(input) do
    input |> Enum.count(&is_safe?/1)
  end

  defp solve_part2(input) do
    input |> Enum.count(fn x -> is_safe?(x) || is_mostly_safe?(x) end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      x
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp is_safe?(array) do
    is_array_decreasing?(array) || is_array_increasing?(array)
  end

  defp is_mostly_safe?(array) do
    array
    |> Enum.with_index()
    |> Enum.any?(fn {_, i} ->
      list_without_x = List.delete_at(array, i)
      is_safe?(list_without_x)
    end)
  end

  defp is_array_decreasing?(array) do
    array
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> (a - b) in 1..3 end)
  end

  defp is_array_increasing?(array) do
    array
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> (b - a) in 1..3 end)
  end
end
