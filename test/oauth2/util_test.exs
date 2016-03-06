defmodule OAuth2Client.UtilTest do
  use ExUnit.Case, async: true

  alias OAuth2Client.Util

  test "parses mime types" do
    assert "application/json" == Util.content_type([])

    assert_raise OAuth2Client.Error, fn ->
      Util.content_type([{"content-type", "trash; trash"}])
    end
  end
end
