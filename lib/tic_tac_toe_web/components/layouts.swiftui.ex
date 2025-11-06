defmodule TicTacToeWeb.Layouts.SwiftUI do
  use TicTacToeNative, [:layout, format: :swiftui]

  embed_templates "layouts_swiftui/*"
end
