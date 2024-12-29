#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule SneakerAdminBench do
  @moduledoc """
  Starts many Shopper connections. Each connection will join a unique CartChannel and
  add a random item.
  """

  def start_connections(chunks \\ 10) when chunks > 0 and chunks <= 50 do
    Enum.each(1..chunks, fn _ ->
      Enum.each(1..100, fn _ -> SneakerAdminBench.Shopper.start([]) end)
      Process.sleep(100)
    end)
  end
end
