defmodule Ex.Stock.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_inventories" do
    field :description, :string
    field :name, :string
    field :unit, :string

    timestamps()
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:unit, :name, :description])
    |> validate_required([:unit, :name, :description])
  end
end
