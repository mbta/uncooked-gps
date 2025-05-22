defmodule UncookedGps do
  def main(_args) do
    url = Application.fetch_env!(:uncooked_gps, :ocs_url)
    team_email = Application.fetch_env!(:uncooked_gps, :team_email)

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

    File.write!("LightRailRawGPS.json", JSON.encode_to_iodata!(vehicles))
  end
end
