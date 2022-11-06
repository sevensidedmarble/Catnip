defmodule CatWeb.PageController do
  use CatWeb, :controller

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end
end
