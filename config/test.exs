import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :catnip, Cat.Repo,
  username: "postgres",
  password: "postgres",
  database: "catnip_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :pow, Pow.Ecto.Schema.Password, iterations: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :catnip, CatWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Q/DNAuFn5mBJQNnpPV//Glj74Uv+S+PcbmktNtTb6e2Q3fm3bWJtfiFHhUvYnhg8",
  server: false

# In test we don't send emails.
config :catnip, Cat.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
