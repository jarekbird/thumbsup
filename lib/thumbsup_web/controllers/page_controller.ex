defmodule ThumbsupWeb.PageController do
  use ThumbsupWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
