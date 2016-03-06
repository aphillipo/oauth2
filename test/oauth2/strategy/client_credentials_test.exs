defmodule OAuth2Client.Strategy.ClientCredentialsTest do
  use ExUnit.Case, async: true

  alias OAuth2Client.Strategy.ClientCredentials
  import OAuth2Client.Client
  import OAuth2Client.TestHelpers

  setup do
    server = Bypass.open
    client = build_client(strategy: ClientCredentials, site: bypass_server(server))
    {:ok, client: client, server: server}
  end

  test "authorize_url", %{client: client} do
    assert_raise OAuth2Client.Error, ~r/This strategy does not implement/, fn ->
      authorize_url(client)
    end
  end

  test "get_token: auth_scheme defaults to 'auth_header'", %{client: client} do
    client = ClientCredentials.get_token(client, [auth_scheme: "auth_header"], [])
    base64 = Base.encode64(client.client_id <> ":" <> client.client_secret)
    assert client.headers == [{"Authorization", "Basic #{base64}"}]
    assert client.params["grant_type"] == "client_credentials"
  end

  test "get_token: with auth_scheme set to 'request_body'", %{client: client} do
    client = ClientCredentials.get_token(client, [auth_scheme: "request_body"], [])
    assert client.headers == []
    assert client.params["grant_type"] == "client_credentials"
    assert client.params["client_id"] == client.client_id
    assert client.params["client_secret"] == client.client_secret
  end
end
