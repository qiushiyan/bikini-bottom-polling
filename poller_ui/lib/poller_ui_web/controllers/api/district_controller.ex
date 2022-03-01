defmodule PollerUiWeb.Api.DistrictController do
  use PollerUiWeb, :controller
  alias PollerDb.Districts

  def index(conn, _params) do
    districts = Districts.list_districts()
    render(conn, "index.json", districts: districts)
  end

  def show(conn, %{"id" => id}) do
    district = Districts.get_district!(id)
    render(conn, "show.json", district: district)
  end
end
