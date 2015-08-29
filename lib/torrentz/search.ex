defmodule Torrentz.Search do
  def perform(query) do
    query
    |> do_search
    |> find_torrents
  end

  defp do_search(query) do
    {:ok, response} = HTTPoison.get("https://torrentz.eu/search?q=" <> URI.encode_www_form(query))
    response.body
  end

  defp find_torrents(html_response) do
    html_response
    |> Floki.find(".results dl")
    |> Enum.map fn(torrent_element) ->
      %{title:       torrent_element |> extract_title,
        rating:      torrent_element |> extract_rating,
        size:        torrent_element |> extract_size,
        uploading:   torrent_element |> extract_uploading,
        downloading: torrent_element |> extract_downloading,
        link:        torrent_element |> extract_link,}
    end
  end

  defp extract_title(torrent_element) do
    {_tag, _attr, title_chunks} = torrent_element |> Floki.find("dt a") |> List.first

    Enum.map_join title_chunks, " ", fn(chunks) ->
      case chunks do
        {_tag, _attr, highlighted_chunks} ->
          List.first(highlighted_chunks)
        _ ->
          String.strip(chunks)
      end
    end
  end

  defp extract_rating(torrent_element) do
    torrent_element |> Floki.find("dd .v") |> Floki.text
  end

  defp extract_size(torrent_element) do
    torrent_element |> Floki.find("dd .s") |> Floki.text
  end

  defp extract_uploading(torrent_element) do
    torrent_element |> Floki.find("dd .u") |> Floki.text
  end

  defp extract_downloading(torrent_element) do
    torrent_element |> Floki.find("dd .d") |> Floki.text
  end

  defp extract_link(torrent_element) do
    path = torrent_element |> Floki.find("dt a") |> Floki.attribute("href") |> List.first
    "https://torrentz.eu" <> path
  end
end
