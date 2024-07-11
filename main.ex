import(ElixirMath)

defmodule Sequetial do
  defmodule LeftTrunc do
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
      init_queue = [2, 3, 5, 7]
      iter_chain(init_queue, [], n)
    end
  end

  defmodule RightTrunc do
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
      init_queue = [2, 3, 5, 7]
      iter_chain(init_queue, [], n)
    end
  end
end

# Example of left truncatable numbers.
# Sequetial.LeftTrunc.list_up_to(1000)
# |> IO.inspect(limit: :infinity)

# Example of right truncatable numbers.
# Sequetial.RightTrunc.list_up_to(1000)
# |> IO.inspect(limit: :infinity)
