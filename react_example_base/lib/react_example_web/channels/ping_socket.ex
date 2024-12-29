#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule ReactExampleWeb.PingSocket do
  use Phoenix.Socket

  channel "ping", ReactExampleWeb.PingChannel
  channel "other", ReactExampleWeb.PingChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
