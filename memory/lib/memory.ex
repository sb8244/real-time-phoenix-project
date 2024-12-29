#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule Memory do
  use GenServer

  def init([]) do
    {:ok, []}
  end

  def handle_call({:allocate, chars}, _from, state) do
    data = Enum.map((1..chars), fn _ -> "a" end)
    {:reply, :ok, [data | state]}
  end

  def handle_call(:clear, _from, _state) do
    {:reply, :ok, []}
  end

  def handle_call(:noop, _from, state) do
    {:reply, :ok, state}
  end

  def handle_call(:clear_hibernate, _from, _state) do
    {:reply, :ok, [], :hibernate}
  end
end
