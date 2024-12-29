#---
# Excerpted from "Real-Time Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
#---
defmodule Sneakers23Web.ProductPageLiveTest do
  use Sneakers23Web.ConnCase, async: false
  import Phoenix.LiveViewTest

  alias Sneakers23.Inventory

  setup _ do
    {inventory, _data} = Test.Factory.InventoryFactory.complete_products()
    {:ok, _} = GenServer.call(Inventory, {:test_set_inventory, inventory})

    {:ok, %{inventory: inventory}}
  end

  defp release_all(%{products: products}) do
    products
    |> Map.keys()
    |> Enum.each(& Inventory.mark_product_released!(&1))
  end

  defp sell_all(%{availability: availability}) do
    availability
    |> Map.values()
    |> Enum.each(fn %{item_id: id, available_count: count} ->
      Enum.each((1..count), fn _ ->
        Sneakers23.Checkout.SingleItem.sell_item(id)
      end)
    end)
  end

  test "the disconnected view renders the product HTML", %{conn: conn} do
    html = get(conn, "/drops") |> html_response(200)
    assert html =~ ~s(<main class="product-list">)
    assert html =~ ~s(coming soon...)
  end

  test "the live view connects", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/drops")
    assert html =~ ~s(<main class="product-list">)
    assert html =~ ~s(coming soon...)
  end

  test "product releases are picked up", %{conn: conn, inventory: inventory} do
    {:ok, view, html} = live(conn, "/drops")
    assert html =~ ~s(coming soon...)

    release_all(inventory)
    html = render(view)

    refute html =~ ~s(coming soon...)
    Enum.each(inventory.items, fn {id, _} ->
      assert html =~ ~s(name="item_id" value="#{id}")
    end)
  end

  test "sold out items are picked up", %{conn: conn, inventory: inventory} do
    {:ok, view, _html} = live(conn, "/drops")

    release_all(inventory)
    sell_all(inventory)
    html = render(view)

    Enum.each(inventory.items, fn {id, _} ->
      assert html =~
        ~s(size-container__entry--level-out" name="item_id" value="#{id}")
    end)
  end
end
