defmodule ExtrisWeb.ExtrisChannel do
  use Phoenix.Channel
  require Logger
  @game_interval 500

  def join(socket, "play", _message) do
    Logger.warn "someone joined..."
    {:ok, game} = Extris.Game.start_link
    :timer.send_interval(@game_interval, game, :tick)
    socket = assign(socket, :game, game)
    spawn(fn() -> ExtrisWeb.Websocket.start(game, socket) end)
    Logger.warn "Assigned game #{inspect socket.assigns[:game]}"
    {:ok, socket}
  end

  def event(socket, "game_event", message) do
    Extris.Game.handle_input(socket.assigns[:game], String.to_atom(message["event"]))
    socket
  end
end
