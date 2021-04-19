defmodule ExWeb.InventoryLive.Index do
  use ExWeb, :live_view

  alias Ex.Stock
  alias Ex.Stock.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :stock_inventories, list_stock_inventories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Inventory")
    |> assign(:inventory, Stock.get_inventory!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Inventory")
    |> assign(:inventory, %Inventory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stock inventories")
    |> assign(:inventory, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    inventory = Stock.get_inventory!(id)
    {:ok, _} = Stock.delete_inventory(inventory)

    {:noreply, assign(socket, :stock_inventories, list_stock_inventories())}
  end

  defp list_stock_inventories do
    Stock.list_stock_inventories()
  end

  @impl true
  def handle_info({:new, inventory}, socket) do
    IO.inspect(inventory)
    {:noreply, socket}
  end
end
