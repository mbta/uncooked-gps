defmodule UncookedGps.FetcherTest do
  use ExUnit.Case

  alias UncookedGps.Fetcher
  import Mock

  @ocs_reply_mock """
  3606,42.343370686319204,-71.1168515041386,2025-06-05 19:29:24
  3607,,
  3608,42.393847580937326,-71.1064506423318,2025-06-05 16:24:41
  """

  setup_with_mocks([
    {Req, [],
     [
       get!: fn _url, _opts ->
         %{body: @ocs_reply_mock}
       end
     ]}
  ]) do
    :ok
  end

  describe "fetch" do
    test "downloads and formats vehicles" do
      assert %{
               "UNKNOWN-3606" => %{
                 speed: nil,
                 bearing: nil,
                 car: "3606",
                 latitude: 42.343370686319204,
                 longitude: -71.1168515041386,
                 updated_at: "2025-06-05T19:29:24-04:00"
               },
               "UNKNOWN-3608" => %{
                 speed: nil,
                 bearing: nil,
                 car: "3608",
                 latitude: 42.393847580937326,
                 longitude: -71.1064506423318,
                 updated_at: "2025-06-05T16:24:41-04:00"
               }
             } == Fetcher.fetch()
    end
  end
end
