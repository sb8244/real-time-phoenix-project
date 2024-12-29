#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule HelloSocketsWeb.TrackedChannelTest do
  use HelloSocketsWeb.ChannelCase

  import ExUnit.CaptureLog
  alias HelloSocketsWeb.{AuthSocket, UserTracker}

  defp connect(id \\ "test") do
    assert {:ok, _, socket} =
      socket(AuthSocket, nil, %{user_id: id})
      |> subscribe_and_join("tracked", %{})

    socket
  end

  # This test will fail until you add the code from "Use Tracker in an Application"
  describe "track/1" do
    test "UserTracker has the Channel when connected" do
      capture_log(fn ->
        connect()
        connect("other")
      end)

      assert [
        {"test", %{online_at: _, phx_ref: _, user_id: "test"}},
        {"other", %{online_at: _, phx_ref: _, user_id: "other"}},
      ] = UserTracker.list()
    end
  end
end
