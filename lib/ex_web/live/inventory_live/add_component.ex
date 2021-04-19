defmodule ExWeb.InventoryLive.AddComponent do
  use ExWeb, :live_component

  alias Ex.Stock
  alias Ex.Stock.Inventory

  @impl true
  def mount(socket) do
    changeset = Stock.change_inventory(%Inventory{})

    {:ok,
     socket
     |> assign(:units, Stock.units())
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("add", %{"inventory" => inventory_params}, socket) do
    case Stock.create_inventory(inventory_params) do
      {:ok, inventory} ->
        send(self(), {:new, inventory})

        {:noreply, assign(socket, changeset: Stock.change_inventory(%Inventory{}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div id="test-stuff">
    <%= f = form_for @changeset, "#",
    id: "add-inventory-form",
    phx_target: @myself,
    phx_submit: "add" %>
    <%= label f, :unit %>
    <%= select f, :unit, @units %>
    <%= error_tag f, :unit %>
    <%= label f, :name %>
    <%= text_input f, :name %>
    <%= error_tag f, :name %>
    <%= label f, :description %>
    <%= text_input f, :description %>
    <%= error_tag f, :description %>
    <%= submit "bug?", phx_disable_with: "Saving..." %>
    </form>
    </div>
    """
  end
end
