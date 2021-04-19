defmodule Ex.StockTest do
  use Ex.DataCase

  alias Ex.Stock

  describe "stock_inventories" do
    alias Ex.Stock.Inventory

    @valid_attrs %{description: "some description", name: "some name", unit: "some unit"}
    @update_attrs %{description: "some updated description", name: "some updated name", unit: "some updated unit"}
    @invalid_attrs %{description: nil, name: nil, unit: nil}

    def inventory_fixture(attrs \\ %{}) do
      {:ok, inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stock.create_inventory()

      inventory
    end

    test "list_stock_inventories/0 returns all stock_inventories" do
      inventory = inventory_fixture()
      assert Stock.list_stock_inventories() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert Stock.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      assert {:ok, %Inventory{} = inventory} = Stock.create_inventory(@valid_attrs)
      assert inventory.description == "some description"
      assert inventory.name == "some name"
      assert inventory.unit == "some unit"
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stock.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{} = inventory} = Stock.update_inventory(inventory, @update_attrs)
      assert inventory.description == "some updated description"
      assert inventory.name == "some updated name"
      assert inventory.unit == "some updated unit"
    end

    test "update_inventory/2 with invalid data returns error changeset" do
      inventory = inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Stock.update_inventory(inventory, @invalid_attrs)
      assert inventory == Stock.get_inventory!(inventory.id)
    end

    test "delete_inventory/1 deletes the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{}} = Stock.delete_inventory(inventory)
      assert_raise Ecto.NoResultsError, fn -> Stock.get_inventory!(inventory.id) end
    end

    test "change_inventory/1 returns a inventory changeset" do
      inventory = inventory_fixture()
      assert %Ecto.Changeset{} = Stock.change_inventory(inventory)
    end
  end
end
