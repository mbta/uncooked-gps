defmodule UncookedGps.HttpTest do
  use ExUnit.Case

  alias UncookedGps.Http
  import Mock

  setup_with_mocks([
    {Req, [],
     [
       get!: fn _url, _opts ->
         "hello GET world"
       end,
       head!: fn _url, _opts ->
         "hello HEAD world"
       end
     ]}
  ]) do
    :ok
  end

  describe "get" do
    test "makes a GET request with user agent" do
      url = "http://localhost"
      assert "hello GET world" == Http.get(url)

      assert_called(Req.get!(url, user_agent: "UncookedGps/0.1.0 (test@localhost)"))
    end
  end

  describe "head" do
    test "makes a HEAD request with user agent" do
      url = "http://localhost"
      assert "hello HEAD world" == Http.head(url)

      assert_called(Req.head!(url, user_agent: "UncookedGps/0.1.0 (test@localhost)"))
    end
  end
end
