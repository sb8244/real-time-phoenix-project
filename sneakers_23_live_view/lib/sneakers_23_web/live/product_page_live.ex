#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule Sneakers23Web.ProductPageLive do
  use Phoenix.LiveView

  alias Sneakers23Web.ProductView

  def render(assigns) do
    Phoenix.View.render(ProductView, "live_index.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, products} = Sneakers23.Inventory.get_complete_products()
    socket = assign(socket, :products, products)

    if connected?(socket) do
      subscribe_to_products(products)
    end

    {:ok, socket}
  end

  def mount(_params, socket) do
    {:ok, products} = Sneakers23.Inventory.get_complete_products()
    socket = assign(socket, :products, products)

    {:ok, socket}
  end

  defp subscribe_to_products(products) do
    Enum.each(products, fn %{id: id} ->
      Phoenix.PubSub.subscribe(Sneakers23.PubSub, "product:#{id}")
    end)
  end

  def handle_info(%{event: "released"}, socket) do
    {:noreply, load_products_from_memory(socket)}
  end

  def handle_info(%{event: "stock_change"}, socket) do
    {:noreply, load_products_from_memory(socket)}
  end

  defp load_products_from_memory(socket) do
    {:ok, products} = Sneakers23.Inventory.get_complete_products()
    assign(socket, :products, products)
  end
end
