Torrentz
==========

Torrentz has functions to search torrentz.eu database.

    iex> Torrentz.search("star wars")
    [%{
    title: "Star Wars 1977 1080p BrRip x264 YIFY",
    rating: "9",
    size: "1742 MB",
    downloading: "343",
    uploading: "1,001",
    link: "https://torrentz.eu/fe1e1069de410fb44157f02b4f6655dde99621c6"
    }, ...]


TODO
-----

- [x] Regular search
- [ ] Filter torrents list by quality (any/good/verified)
- [ ] Order torrents list by rating, date etc
- [ ] Get torrent details

FIXME
------

- [ ] Handle `{:error, %HTTPoison.Error{id: nil, reason: :timeout}}`.
