defmodule TicTacToeWeb.HomeLive do
  @moduledoc """
  Home page
  """

  use TicTacToeWeb, :live_view

  use LiveViewNative.LiveView,
    formats: [:swiftui],
    layouts: [
      swiftui: {TicTacToeWeb.Layouts.SwiftUI, :app}
    ]

  alias TicTacToe.BoardEvaluator

  @board Enum.map(1..9, &{to_string(&1), nil})
  @players ~w(X O)a

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, init_game(socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("restart", _params, socket) do
    {:noreply, init_game(socket)}
  end

  def handle_event(
        "cell_clicked",
        %{"index" => index},
        %{assigns: %{board: board, current_player: current_player, board_state: :ongoing}} =
          socket
      ) do
    socket =
      case update_board(board, current_player, index) do
        {:ok, updated_board} ->
          socket
          |> assign(:board, updated_board)
          |> update(:current_player, &switch_current_player/1)

        :skip ->
          socket
      end

    {:noreply, evaluate_board(socket)}
  end

  def handle_event("cell_clicked", _params, socket) do
    {:noreply, socket}
  end

  defp init_game(socket) do
    socket
    |> assign(:current_player, hd(@players))
    |> assign(:board, @board)
    |> assign(:board_state, :ongoing)
  end

  defp update_board(board, current_player, index) do
    with board_index when is_integer(board_index) <-
           Enum.find_index(board, fn {board_index, _} -> board_index == index end),
         {_, nil} <- Enum.at(board, board_index) do
      {:ok, List.replace_at(board, board_index, {index, current_player})}
    else
      _ -> :skip
    end
  end

  defp switch_current_player(current_player) do
    @players |> Enum.reject(&(&1 == current_player)) |> hd()
  end

  defp evaluate_board(socket) do
    board = Map.new(socket.assigns.board)
    assign(socket, :board_state, BoardEvaluator.evaluate(board))
  end

  defp cell_color(:X), do: "bg-red-300"
  defp cell_color(:O), do: "bg-purple-300"
  defp cell_color(_), do: "bg-white"
end
