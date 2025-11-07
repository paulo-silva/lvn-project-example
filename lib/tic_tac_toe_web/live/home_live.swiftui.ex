defmodule TicTacToeWeb.HomeLive.SwiftUI do
  @moduledoc """
  Home page for iOS
  """

  use TicTacToeNative, [:render_component, format: :swiftui]

  def render(assigns, %{"target" => "watchos"}) do
    assigns = assign(assigns, :rows, Enum.chunk_every(assigns.board, 3))

    ~LVN"""
    <VStack>
      <HStack>
        <%= case @board_state do %>
          <% :ongoing -> %>
            <Text>Jogo em progresso</Text>
          <% {:winner, winner} -> %>
            <Text>{"#{winner} venceu!"}</Text>
          <% :tie -> %>
            <Text>{"Empate!"}</Text>
        <% end %>
      </HStack>
      <HStack>
        <Button phx-click="restart" style={".buttonStyle(.plain); .controlSize(.small)"}>
          <Text style={".padding(2); .background(Color.orange);"}>Reiniciar Game</Text>
        </Button>
      </HStack>
      <Grid alignment="center" horizontalSpacing="20" verticalSpacing="20" style=".padding()">
        <GridRow :for={row <- @rows} alignment="center">
          <Button
            :for={{cell_index, cell_value} <- row}
            id={"cell-#{cell_index}"}
            phx-click="cell_clicked"
            phx-value-index={cell_index}
            style={".buttonStyle(.borderedProminent); .controlSize(.mini);"}
          >
            <%= if cell_value do %>
              <Label>{cell_value}</Label>
            <% else %>
              <Label>_</Label>
            <% end %>
          </Button>
        </GridRow>
      </Grid>
    </VStack>
    """
  end

  def render(assigns, _interface) do
    assigns = assign(assigns, :rows, Enum.chunk_every(assigns.board, 3))

    ~LVN"""
    <VStack>
      <HStack>
        <%= case @board_state do %>
          <% :ongoing -> %>
            <Text>Jogo em progresso</Text>
          <% {:winner, winner} -> %>
            <Text>{"#{winner} venceu!"}</Text>
          <% :tie -> %>
            <Text>{"Empate!"}</Text>
        <% end %>
      </HStack>
      <HStack>
        <Button phx-click="restart"><Text>Reiniciar Game</Text></Button>
      </HStack>
      <Grid alignment="center" horizontalSpacing="20" verticalSpacing="20" style=".padding()">
        <GridRow :for={row <- @rows} alignment="center">
          <Button
            :for={{cell_index, cell_value} <- row}
            id={"cell-#{cell_index}"}
            phx-click="cell_clicked"
            phx-value-index={cell_index}
            style={".buttonStyle(.borderedProminent); .controlSize(.large);"}
          >
            <%= if cell_value do %>
              <Label>{cell_value}</Label>
            <% else %>
              <Label>_</Label>
            <% end %>
          </Button>
        </GridRow>
      </Grid>
    </VStack>
    """
  end
end
