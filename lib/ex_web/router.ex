defmodule ExWeb.Router do
  use ExWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {ExWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ExWeb do
    pipe_through(:browser)

    live("/", PageLive, :index)

    live("/stock_inventories", InventoryLive.Index, :index)
    live("/stock_inventories/new", InventoryLive.Index, :new)
    live("/stock_inventories/:id/edit", InventoryLive.Index, :edit)

    live("/stock_inventories/:id", InventoryLive.Show, :show)
    live("/stock_inventories/:id/show/edit", InventoryLive.Show, :edit)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExWeb do
  #   pipe_through :api
  # end
end
