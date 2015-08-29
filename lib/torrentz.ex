defmodule Torrentz do
  alias Torrentz.Search

  def search(query) do
    Search.perform(query)
  end
end
