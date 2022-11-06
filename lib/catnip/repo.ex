defmodule Cat.Repo do
  use Ecto.Repo,
    otp_app: :catnip,
    adapter: Ecto.Adapters.Postgres
end
