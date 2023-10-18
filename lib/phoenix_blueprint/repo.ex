defmodule PhoenixBlueprint.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_blueprint,
    adapter: Ecto.Adapters.Postgres
end
