# defmodule ElixirBenchmarking do
#  @moduledoc """
#  Documentation for `ElixirBenchmarking`.
#  """
#
#  @doc """
#  Hello world.
#
#  ## Examples
#
#      iex> ElixirBenchmarking.hello()
#      :world
#
#  """
#  def hello do
#    :world
#  end
# end

defmodule ElixirBenchmarking do
  def list(number), do: Enum.map(0..number, &fibonacci/1)

  def list_alternate(number),
    do: Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(number)

  def fibonacci(0), do: 0
  def fibonacci(1), do: 1
  def fibonacci(n), do: fibonacci(0, 1, n - 2)

  def fibonacci(_, prv, -1), do: prv

  def fibonacci(prvprv, prv, n) do
    next = prv + prvprv
    fibonacci(prv, next, n - 1)
  end
end

#
# Benchee.run(%{
#  "10_seq" => fn -> ElixirBenchmarking.list(10) end
# })
