import Config

if config_env() != :test do
  config :uncooked_gps, ocs_url: System.fetch_env!("OCS_URL")
  config :uncooked_gps, team_email: System.fetch_env!("TEAM_EMAIL")
  config :uncooked_gps, s3_bucket: System.get_env("S3_BUCKET")
  config :uncooked_gps, s3_path: System.get_env("S3_PATH")
  config :uncooked_gps, poll_delay_ms: System.get_env("POLL_DELAY_MS", "#{6 * 60 * 60 * 1000}")
end
