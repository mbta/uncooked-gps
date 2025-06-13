import Config

config :uncooked_gps, ocs_url: "http://localhost/test"
config :uncooked_gps, team_email: "test@localhost"
config :uncooked_gps, poll_delay_ms: "86400000"

config :logger,
  # Print only warnings and errors during test
  level: :warning
