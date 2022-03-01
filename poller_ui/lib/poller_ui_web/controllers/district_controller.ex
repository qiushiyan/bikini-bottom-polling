defmodule PollerUiWeb.DistrictController do
  use PollerUiWeb, :controller
  alias PollerDb.Districts

  def index(conn, _params) do
    render(conn, "index.html", districts: PollerDb.Districts.list_districts())
  end

  def new(conn, _params) do
    changeset = Districts.change_district()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"district" => district_params}) do
    case Districts.cretae_district(district_params) do
      {:ok, _district} ->
        conn
        |> put_flash(:info, "district created successfully")
        |> redirect(to: Routes.district_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    district = PollerDb.Districts.get_district!(id)
    changeset = Districts.change_district()
    render(conn, "edit.html", district: district, changeset: changeset)
  end

  def update(conn, %{"id" => id, "district" => district_params}) do
    district = Districts.get_district!(id)

    case Districts.update_district(district, district_params) do
      {:ok, _district} ->
        conn
        |> put_flash(:info, "district updated successfully")
        |> redirect(to: Routes.district_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", district: district, changeset: changeset)
    end
  end
end
