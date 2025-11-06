defmodule TicTacToe.BoardEvaluator do
  @moduledoc """
  Evaluates the tic tac toe board result
  """

  @type player() :: :X | :O

  @players ~w(X O)a

  @spec players() :: list(player())
  def players, do: @players

  @winning_possibilities [
    ~w(1 2 3),
    ~w(4 5 6),
    ~w(7 8 9),
    ~w(1 4 7),
    ~w(2 5 8),
    ~w(3 6 9),
    ~w(1 5 9),
    ~w(3 5 7)
  ]

  @spec evaluate(board :: map()) :: {:winner, player()} | :tie | :ongoing
  def evaluate(board) do
    default_result =
      if Enum.any?(board, fn {_, value} -> is_nil(value) end) do
        :ongoing
      else
        :tie
      end

    Enum.reduce_while(
      @winning_possibilities,
      default_result,
      &check_winning_possibility(board, &1, &2)
    )
  end

  defp check_winning_possibility(board, winning_possibility, default_result) do
    board
    |> Map.take(winning_possibility)
    |> Map.values()
    |> Enum.uniq()
    |> case do
      [winner] when winner in @players -> {:halt, {:winner, winner}}
      _ -> {:cont, default_result}
    end
  end
end
