defmodule UncookedGps.Health do
  alias UncookedGps.Http

  require Logger

  @spec healthy?() :: any()
  def healthy? do
    ocs_url = Application.fetch_env!(:uncooked_gps, :ocs_url)
    uri = URI.new!(ocs_url)

    Http.head("#{uri.scheme}://#{uri.host}:#{uri.port}")
    Logger.info("healthy")
  end
end
