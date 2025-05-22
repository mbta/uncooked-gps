import Config

config :uncooked_gps, ocs_url: System.fetch_env!("OCS_URL")
config :uncooked_gps, team_email: System.fetch_env!("TEAM_EMAIL")
config :uncooked_gps, s3_bucket: System.get_env("S3_BUCKET")
config :uncooked_gps, s3_path: System.get_env("S3_PATH")
