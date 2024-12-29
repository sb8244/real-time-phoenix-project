#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule HelloSockets.Pipeline.Producer do
  use GenStage

  def start_link(opts) do
    {[name: name], opts} = Keyword.split(opts, [:name])
    GenStage.start_link(__MODULE__, opts, name: name)
  end

  def init(_opts) do
    {:producer, :unused, buffer_size: 10_000}
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end

  def push(item = %{}) do
    GenStage.cast(__MODULE__, {:notify, item})
  end

  def handle_cast({:notify, item}, state) do
    {:noreply, [%{item: item}], state}
  end

  alias HelloSockets.Pipeline.Timing

  def push_timed(item = %{}) do
    GenStage.cast(__MODULE__, {:notify_timed, item, Timing.unix_ms_now()})
  end

  def handle_cast({:notify_timed, item, unix_ms}, state) do
    {:noreply, [%{item: item, enqueued_at: unix_ms}], state}
  end
end
