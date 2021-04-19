defmodule Ex.Repo.Migrations.CreateStockInventories do
  use Ecto.Migration

  def change do
    create table(:stock_inventories) do
      add :unit, :string
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
