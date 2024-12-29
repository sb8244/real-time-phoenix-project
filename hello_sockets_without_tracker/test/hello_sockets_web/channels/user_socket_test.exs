#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule HelloSocketsWeb.UserSocketTest do
  use HelloSocketsWeb.ChannelCase
  alias HelloSocketsWeb.UserSocket

  describe "connect/3" do
    test "can be connected to without parameters" do
      assert {:ok, %Phoenix.Socket{}} = connect(UserSocket, %{})
    end
  end

  describe "id/1" do
    test "an identifier is not provided" do
      assert {:ok, socket} = connect(UserSocket, %{})
      assert UserSocket.id(socket) == nil
    end
  end
end
