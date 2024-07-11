import(ElixirMath)

defmodule LeftTrunc do
  @moduledoc """
  Get a list of all left-truncatable prime number up to a given number n,
  using function list_up_to(n).
  """

  # Base case, finished.
  defp iter_chain(queue, result, stop_after) when hd(queue) > stop_after do
    Enum.sort(result)
  end

  # Prime check.
  defp iter_chain(queue, result, stop_after) do
    cond do
      is_prime(hd(queue)) -> found_prime(queue, result, stop_after)
      true -> iter_chain(tl(queue), result, stop_after)
    end
  end

  defp found_prime(queue, result, stop_after) do
    current = hd(queue)
    result = [current | result]

    next_most_digit_base = 10 ** length(Integer.digits(current))

    next_block =
      for d <- 1..9 do
        d * next_most_digit_base + current
      end

    queue = queue ++ next_block

    iter_chain(tl(queue), result, stop_after)
  end

  def list_up_to(n) do
    iter_chain([2, 3, 5, 7], [], n)
  end
end

defmodule RightTrunc do
  @moduledoc """
  Get a list of all right-truncatable prime number up to a given number n,
  using function list_up_to(n).
  """

  # Base case, finished.
  defp iter_chain(queue, result, stop_after) when hd(queue) > stop_after do
    Enum.sort(result)
  end

  # Prime check.
  defp iter_chain(queue, result, stop_after) do
    cond do
      is_prime(hd(queue)) -> found_prime(queue, result, stop_after)
      true -> iter_chain(tl(queue), result, stop_after)
    end
  end

  defp found_prime(queue, result, stop_after) do
    current = hd(queue)
    result = [current | result]

    next_block =
      for d <- [1, 3, 7, 9] do
        current * 10 + d
      end

    queue = queue ++ next_block

    iter_chain(tl(queue), result, stop_after)
  end

  def list_up_to(n) do
    iter_chain([2, 3, 5, 7], [], n)
  end
end

defmodule LeftRightTrunc do
  @moduledoc """
  Get a list of all left-right-truncatable prime numbers up to a given number n,
  using function list_up_to(n).
  """

  # Base case, finished.
  defp iter_chain(queue, result, stop_after) when hd(queue) > stop_after do
    Enum.sort(result)
  end

  # Prime check.
  defp iter_chain(queue, result, stop_after) do
    cond do
      is_prime(hd(queue)) -> found_prime(queue, result, stop_after)
      true -> iter_chain(tl(queue), result, stop_after)
    end
  end

  defp found_prime(queue, result, stop_after) do
    current = hd(queue)
    result = [current | result]

    # * 10 to account for the least significant digit.
    next_most_digit_base = 10 ** length(Integer.digits(current)) * 10

    next_block =
      for msd <- 1..9 do
        for lsd <- 1..9 do
          msd * next_most_digit_base + current * 10 + lsd
        end
      end
      |> List.flatten()

    queue = queue ++ next_block

    iter_chain(tl(queue), result, stop_after)
  end

  def list_up_to(n) do
    [
      2,
      3,
      5,
      7,
      11,
      13,
      17,
      19,
      23,
      29,
      31,
      37,
      41,
      43,
      47,
      53,
      59,
      61,
      67,
      71,
      73,
      79,
      83,
      89,
      97
    ]
    |> iter_chain([], n)
  end
end

# Example of left truncatable numbers.
# LeftTrunc.list_up_to(1000)
# |> IO.inspect(limit: :infinity)

# Example of right truncatable numbers.
# RightTrunc.list_up_to(1000)
# |> IO.inspect(limit: :infinity)

# Example of left-right truncatable numbers.
# LeftRightTrunc.list_up_to(1000)
# |> IO.inspect(limit: :infinity)
