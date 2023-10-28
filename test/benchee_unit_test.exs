defmodule BencheeUnitTest do
  use ExUnit.Case
  alias Application.TestHelper

#  @tag :benchmark
#  test "benchmark fibonacci list generation" do
#    # capture benchee output to run assertions
#    output =
#      Benchee.run(%{
#        "case_10_numbers" => fn ->
#          ElixirBenchmarking.list(10)
#        end,
#        "case_1000_numbers" => fn ->
#          ElixirBenchmarking.list(1000)
#        end
#      })
#
#    results = Enum.at(output.scenarios, 0)
#    assert results.run_time_data.statistics.average <= 50_000_000
#  end
#
#  @tag :benchmark
#  test "benchmark fibonacci list generation with a input map" do
#    # capture benchee output to run assertions
#    output =
#      Benchee.run(
#        %{
#          "generate_list" => fn input ->
#            ElixirBenchmarking.list(input)
#          end
#        },
#        inputs: %{
#          "case_10" => 10,
#          "case_100" => 100,
#          "case_1000" => 1000,
#          "case_10000" => 10000,
#          "case_100000" => 100_000
#        }
#      )
#
#    results = Enum.at(output.scenarios, 0)
#    assert results.run_time_data.statistics.average <= 50_000_000
#  end

  @tag :benchmark
  @tag timeout: :infinity
  test "benchmark fibonacci list generation optimised function" do
    # capture benchee output to run assertions
    output = Benchee.run(%{
      "generate_list_enum" => fn(input) ->
                                ElixirBenchmarking.list(input)
      end,
      "generate_list_stream" => fn(input) ->
                                  ElixirBenchmarking.list_alternate(input)
      end
    },
      inputs: %{
        "case_10" => 10,
        "case_100" => 100,
        "case_1000" => 1000,
        "case_10000" => 10000,
      })

    results = Enum.at(output.scenarios, 0)
    assert results.run_time_data.statistics.average <= 50_000_000
  end


  @tag :benchmark
  @tag timeout: :infinity
  test "benchmark fibonacci list generation report html" do
    # capture benchee output to run assertions
    output = Benchee.run(%{
      "generate_list_enum" => fn(input) ->
                                ElixirBenchmarking.list(input)
      end,
      "generate_list_stream" => fn(input) ->
                                  ElixirBenchmarking.list_alternate(input)
      end
    },
      inputs: %{
        "case_10" => 10,
        "case_100" => 100,
        "case_1000" => 1000,
        "case_10000" => 10000,
      },
      formatters: [
        Benchee.Formatters.HTML,
        Benchee.Formatters.Console
      ])

    results = Enum.at(output.scenarios, 0)
    assert results.run_time_data.statistics.average <= 50_000_000
  end
end
