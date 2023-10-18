defmodule PheonixBlueprint.Repo do
  use Ecto.Repo,
    otp_app: :pheonix_blueprint,
    adapter: Ecto.Adapters.Postgres
end
