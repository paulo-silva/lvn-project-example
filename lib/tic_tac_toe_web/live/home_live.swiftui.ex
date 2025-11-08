defmodule TicTacToeWeb.HomeLive.SwiftUI do
  @moduledoc """
  Home page for iOS
  """

  use TicTacToeNative, [:render_component, format: :swiftui]

  def render(assigns, %{"target" => "watchos"}) do
    assigns = assign(assigns, :rows, Enum.chunk_every(assigns.board, 3))

    ~LVN"""
    <VStack spacing="8" style=".padding()">
      <Spacer />
      <Spacer />
      <%= case @board_state do %>
        <% :ongoing -> %>
          <Text style={".font(.headline); .foregroundStyle(.secondary)"}>Jogo em progresso</Text>
        <% {:winner, winner} -> %>
          <Text style={".font(.smallTitle); .fontWeight(.bold); .foregroundStyle(.green);"}>{"🎉 #{winner} venceu!"}</Text>
        <% :tie -> %>
          <Text style={".font(.smallTitle); .fontWeight(.bold); .foregroundStyle(.orange)"}>{"🤝 Empate!"}</Text>
      <% end %>
      <Grid alignment="center" horizontalSpacing="4" verticalSpacing="4">
        <GridRow :for={row <- @rows} alignment="center">
          <Button
            :for={{cell_index, cell_value} <- row}
            id={"cell-#{cell_index}"}
            phx-click="cell_clicked"
            phx-value-index={cell_index}
            style={".buttonStyle(.bordered); .controlSize(.mini);"}
          >
            <%= if cell_value do %>
              <Text style={".font(.system(size: 16)); .fontWeight(.semibold)"}>{cell_value}</Text>
            <% else %>
              <Text style={".foregroundStyle(.tertiary)"}> </Text>
            <% end %>
          </Button>
        </GridRow>
      </Grid>
      <Spacer />
      <Button phx-click="restart" style={".buttonStyle(.borderedProminent); .controlSize(.small); .tint(.green)"}>
        <Label systemImage="arrow.clockwise">Reiniciar</Label>
      </Button>
    </VStack>
    """
  end

  def render(assigns, _interface) do
    assigns = assign(assigns, :rows, Enum.chunk_every(assigns.board, 3))

    ~LVN"""
    <VStack spacing="20" style=".padding()">
      <Spacer />
      <VStack spacing="10">
        <Text style={".font(.largeTitle); .fontWeight(.black); .foregroundStyle(.blue)"}>Jogo da Velha</Text>
        <%= case @board_state do %>
          <% :ongoing -> %>
            <Text style={".font(.title2); .foregroundStyle(.secondary)"}>Sua vez de jogar</Text>
          <% {:winner, winner} -> %>
            <Text style={".font(.title); .fontWeight(.bold); .foregroundStyle(.green)"}>{"🎉 #{winner} venceu!"}</Text>
          <% :tie -> %>
            <Text style={".font(.title); .fontWeight(.bold); .foregroundStyle(.orange)"}>{"🤝 Empate!"}</Text>
        <% end %>
      </VStack>
      <Spacer />
      <Grid alignment="center" horizontalSpacing="12" verticalSpacing="12">
        <GridRow :for={row <- @rows} alignment="center">
          <Button
            :for={{cell_index, cell_value} <- row}
            id={"cell-#{cell_index}"}
            phx-click="cell_clicked"
            phx-value-index={cell_index}
            style={".buttonStyle(.bordered); .controlSize(.extraLarge);"}
          >
            <Text style={".font(.system(size: 48)); .fontWeight(.bold)"}>{cell_value || "_"}</Text>
          </Button>
        </GridRow>
      </Grid>
      <Spacer />
      <Button phx-click="restart" style={".buttonStyle(.borderedProminent); .controlSize(.large); .tint(.green)"}>
        <Label systemImage="arrow.clockwise">Reiniciar Jogo</Label>
      </Button>
      <Spacer />
    </VStack>
    """
  end
end
