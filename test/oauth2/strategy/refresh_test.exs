defmodule OAuth2Client.Strategy.RefreshTest do

  use ExUnit.Case, async: true

  import OAuth2Client.TestHelpers

  alias OAuth2Client.Strategy.Refresh

  test "authorize_url" do
    assert_raise OAuth2Client.Error, ~r/This strategy does not implement/, fn ->
      Refresh.authorize_url(build_client(), [])
    end
  end

  test "get_token" do
    client = build_client()
    client = Refresh.get_token(client, [refresh_token: "refresh-token"], [])
    assert client.params["grant_type"] == "refresh_token"
    assert client.params["refresh_token"] == "refresh-token"
    assert client.params["client_id"] == client.client_id
    assert client.params["client_secret"] == client.client_secret
  end

  test "get_token throws and error if there is no 'refresh_token' param" do
    assert_raise OAuth2Client.Error, ~r/Missing required key `refresh_token`/, fn ->
      Refresh.get_token(build_client(), [], [])
    end
  end
end
