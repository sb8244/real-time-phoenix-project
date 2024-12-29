#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule Integration.PipelineTest do
  use HelloSocketsWeb.ChannelCase, async: false

  alias HelloSocketsWeb.AuthSocket
  alias HelloSockets.Pipeline.Producer

  defp connect_auth_socket(user_id) do
    {:ok, _, %Phoenix.Socket{}} =
      socket(AuthSocket, nil, %{user_id: user_id})
      |> subscribe_and_join("user:#{user_id}", %{})
  end

  test "event are pushed from begining to end correctly" do
    connect_auth_socket(1)

    Enum.each(1..10, fn n ->
      Producer.push_timed(%{data: %{n: n}, user_id: 1})
      assert_push "push_timed", %{n: ^n}
    end)
  end

  test "an event is not delivered to the wrong user" do
    connect_auth_socket(2)

    Producer.push_timed(%{data: %{test: true}, user_id: 1})
    refute_push "push_timed", %{test: true}
  end

  test "events are timed on delivery" do
    assert {:ok, _} = StatsDLogger.start_link(port: 8127, formatter: :send)
    connect_auth_socket(1)

    Producer.push_timed(%{data: %{test: true}, user_id: 1})

    assert_push "push_timed", %{test: true}
    assert_receive {:statsd_recv, "pipeline.push_delivered", _value}
  end
end
