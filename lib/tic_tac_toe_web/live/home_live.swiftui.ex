defmodule TicTacToeWeb.HomeLive.SwiftUI do
  @moduledoc """
  Home page for iOS
  """

  use TicTacToeNative, [:render_component, format: :swiftui]

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
          >
            <%= if cell_value do %>
              <Label>{cell_value}</Label>
            <% else %>
              <Label systemImage="placeholdertext.fill">{cell_value}</Label>
            <% end %>
          </Button>
        </GridRow>
      </Grid>
    </VStack>
    """
  end
end
