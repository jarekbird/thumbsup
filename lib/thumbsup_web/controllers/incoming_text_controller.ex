defmodule ThumbsupWeb.IncomingTextController do
  use ThumbsupWeb, :controller

  alias Thumbsup.Surveys
  alias Thumbsup.Surveys.IncomingText
  alias Thumbsup.Accounts

  # action_fallback ThumbsupWeb.FallbackController

  plug :assign_user

  def bandwidth_create(conn, params) do
    with {:ok, %IncomingText{} = incoming_text} <- Surveys.create_incoming_text(bandwidth_incoming_text_params(conn, params)) do
      conn
      |> put_status(:created)
      |> send_resp(204, "")
    end
  end

  defp assign_user(conn, _extra_params) do
    params = conn.body_params
    user_id = Accounts.get_user_by_phone_number(params["from"]).id
    assign(conn, :user_id, user_id)
  end

  defp bandwidth_incoming_text_params(conn, params) do
    %{user_id: conn.assigns[:user_id], body: params["text"]}
  end
end
