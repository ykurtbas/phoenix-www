defmodule ExWeb.InventoryLive.FormComponent do
  use ExWeb, :live_component

  alias Ex.Stock

  @impl true
  def update(%{inventory: inventory} = assigns, socket) do
    changeset = Stock.change_inventory(inventory)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"inventory" => inventory_params}, socket) do
    changeset =
      socket.assigns.inventory
      |> Stock.change_inventory(inventory_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"inventory" => inventory_params}, socket) do
    save_inventory(socket, socket.assigns.action, inventory_params)
  end

  defp save_inventory(socket, :edit, inventory_params) do
    case Stock.update_inventory(socket.assigns.inventory, inventory_params) do
      {:ok, _inventory} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_inventory(socket, :new, inventory_params) do
    case Stock.create_inventory(inventory_params) do
      {:ok, _inventory} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
