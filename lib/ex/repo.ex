defmodule Ex.Repo do
  use Ecto.Repo,
    otp_app: :ex,
    adapter: Ecto.Adapters.MyXQL
end
