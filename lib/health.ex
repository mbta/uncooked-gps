defmodule UncookedGps.Health do
  alias UncookedGps.Http

  require Logger

  @spec healthy?() :: :ok
  def healthy? do
    ocs_url = Application.fetch_env!(:uncooked_gps, :ocs_url)
    uri = URI.new!(ocs_url)

    # This raises on failure
    Http.head("#{uri.scheme}://#{uri.host}:#{uri.port}")
    Logger.info("healthy")
    :ok
  end
end
