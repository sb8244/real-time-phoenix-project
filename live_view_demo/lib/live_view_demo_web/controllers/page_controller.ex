#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule LiveViewDemoWeb.PageController do
  use LiveViewDemoWeb, :controller
  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    live_render(conn, LiveViewDemoWeb.CounterLive, session: %{
      count: :rand.uniform(100_000)
    })
  end
end
