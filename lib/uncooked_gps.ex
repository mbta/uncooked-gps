defmodule UncookedGps do
  alias ExAws.S3

  def main(_args) do
    url = Application.fetch_env!(:uncooked_gps, :ocs_url)
    team_email = Application.fetch_env!(:uncooked_gps, :team_email)
    s3_bucket = Application.get_env(:uncooked_gps, :s3_bucket)
    s3_path = Application.get_env(:uncooked_gps, :s3_path)

    user_agent = "UncookedGps/0.1.0 (#{team_email})"
    IO.puts("[#{user_agent}] Fetching #{url}")
    resp = Req.get!(url, user_agent: user_agent)

    vehicles =
      resp.body
      |> String.split("\n", trim: true)
      |> Map.new(fn line ->
        case String.split(line, ",") do
          [_, "", ""] ->
            {nil, nil}

          [car, latitude, longitude, timestamp_local] ->
            {:ok, timestamp_naive} =
              timestamp_local
              |> NaiveDateTime.from_iso8601()

            timestamp =
              timestamp_naive |> DateTime.from_naive!("America/New_York") |> DateTime.to_iso8601()

            {"UNKNOWN-#{car}",
             %{
               bearing: nil,
               car: car,
               latitude: latitude,
               longitude: longitude,
               speed: nil,
               updated_at: timestamp
             }}
        end
      end)
      |> Map.delete(nil)

    data = JSON.encode_to_iodata!(vehicles)

    if s3_bucket != nil do
      IO.puts("Writing to s3://#{s3_bucket}/#{s3_path}...")
      S3.put_object(s3_bucket, s3_path, data)
    else
      path = "LightRailRawGPS.json"
      IO.puts("Writing to file://#{path}...")
      File.write!(path, data)
    end
  end
end
