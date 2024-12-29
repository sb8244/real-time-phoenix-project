#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule HelloSockets.Pipeline.Worker do

  def start_link(item) do
    Task.start_link(fn ->
      HelloSockets.Statix.measure("pipeline.worker.process_time", fn ->
        process(item)
      end)
    end)
  end


  def start_link(item) do
    Task.start_link(fn ->
      process(item)
    end)
  end


  defp process(%{
         item: %{data: data, user_id: user_id},
         enqueued_at: unix_ms
       }) do
    HelloSocketsWeb.Endpoint.broadcast!("user:#{user_id}", "push_timed", %{
      data: data,
      at: unix_ms
    })
  end


  defp process(%{item: %{data: data, user_id: user_id}}) do
    Process.sleep(1000)
    HelloSocketsWeb.Endpoint.broadcast!("user:#{user_id}", "push", data)
  end


  defp process(item) do
    IO.inspect(item)
    Process.sleep(1000)
  end

end
