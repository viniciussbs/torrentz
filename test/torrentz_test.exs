defmodule TorrentzTest do
  use ExUnit.Case

  test "search returns a list of torrents" do
    [torrent|_] = Torrentz.search("star wars")

    # IMPROVEMENT: 1 assert per test
    assert torrent.title       =~ ~r/star wars/i
    assert torrent.link        =~ ~r/\Ahttps?:/
    assert torrent.rating      =~ ~r/\A\d+\z/
    assert torrent.size        =~ ~r/\A\d+ \w+\z/i
    assert torrent.uploading   =~ ~r/\A\d[0-9,]+\z/
    assert torrent.downloading =~ ~r/\A\d[0-9,]+\z/
  end
end
