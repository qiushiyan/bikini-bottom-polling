defmodule Poller.Candidate do
  alias __MODULE__
  defstruct id: nil, name: nil, party: nil

  def new(id, name, party) do
    %Candidate{id: id, name: name, party: party}
  end
end
