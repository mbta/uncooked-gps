defmodule UncookedGps.Fetcher do
  alias UncookedGps.Http
  alias ExAws.S3

  require Logger
  use GenServer

  @wait_ms 60 * 60 * 1000

  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(_) do
    Logger.info("Starting fetcher delay_ms=#{@wait_ms}")
    GenServer.start_link(__MODULE__, nil)
  end

  @spec init(any()) :: {:ok, nil}
  def init(_state) do
    schedule()
    {:ok, nil}
  end

  def handle_info(:poll, _state) do
    upload(fetch())

    schedule()
    {:noreply, nil}
  end

  @spec fetch() :: map()
  def fetch() do
    ocs_url = Application.fetch_env!(:uncooked_gps, :ocs_url)

    resp = Http.get(ocs_url)

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
  end

  def upload(vehicles) do
    s3_bucket = Application.get_env(:uncooked_gps, :s3_bucket)
    s3_path = Application.get_env(:uncooked_gps, :s3_path)
    data = JSON.encode!(vehicles)

    if s3_bucket != nil do
      request = S3.put_object(s3_bucket, s3_path, data)
      ExAws.request(request)
      Logger.info("write path=s3://#{s3_bucket}/#{s3_path}")
    else
      path = "LightRailRawGPS.json"
      File.write!(path, data)
      Logger.info("write path=file://#{path}")
    end
  end

  defp schedule() do
    # hourly
    Process.send_after(self(), :poll, @wait_ms)
  end
end
