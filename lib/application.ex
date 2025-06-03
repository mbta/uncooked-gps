defmodule UncookedGps.Application do
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      UncookedGps.Fetcher
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
