defmodule OAuth2Test do
  use ExUnit.Case
  import OAuth2Client.TestHelpers

  @client build_client(client_id: "abc123",
                     client_secret: "xyz987",
                     site: "https://api.github.com",
                     redirect_uri: "http://localhost/auth/callback")

  test "`new` delegates to `OAuth2Client.Client.new/1`" do
    client = @client
    assert client.strategy == OAuth2Client.Strategy.AuthCode
    assert client.site == "https://api.github.com"
    assert client.client_id == "abc123"
    assert client.client_secret == "xyz987"
    assert client.site == "https://api.github.com"
    assert client.authorize_url == "/oauth/authorize"
    assert client.token_url == "/oauth/token"
    assert client.token_method == :post
    assert client.params == %{}
    assert client.headers == []
    assert client.redirect_uri == "http://localhost/auth/callback"
  end
end

