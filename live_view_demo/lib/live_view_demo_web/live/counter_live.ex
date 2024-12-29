#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule LiveViewDemoWeb.CounterLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    Current count: <%= @count %>
    <button phx-click="dec">-</button>
    <button phx-click="inc">+</button>
    """
  end

  def mount(%{count: initial}, socket) do
    {:ok, assign(socket, :count, initial)}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
