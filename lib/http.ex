defmodule UncookedGps.Http do
  require Logger

  def user_agent do
    team_email = Application.fetch_env!(:uncooked_gps, :team_email)
    "UncookedGps/0.1.0 (#{team_email})"
  end

  def get(url) do
    resp = Req.get!(url, user_agent: user_agent())
    Logger.info("get url=#{url} agent=#{user_agent()}")
    resp
  end

  def head(url) do
    resp = Req.head!(url, user_agent: user_agent())
    Logger.info("head url=#{url} agent=#{user_agent()}")
    resp
  end
end
