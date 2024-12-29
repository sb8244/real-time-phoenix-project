#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule ReactExampleWeb.PingChannel do
  use Phoenix.Channel

  @topics ["ping", "other"]

  def join(topic, _params, socket) when topic in @topics do
    send(self(), :send_ping)

    {:ok, socket}
  end

  def handle_in("ping", %{}, socket) do
    {:reply, {:ok, %{pong: "true"}}, socket}
  end

  def handle_info(:send_ping, socket) do
    push(socket, "ping", %{
      message: "ping",
      random: :rand.uniform(100_000),
      node: Node.self()
    })

    schedule()

    {:noreply, socket}
  end

  defp schedule() do
    Process.send_after(self(), :send_ping, 2_000)
  end
end
