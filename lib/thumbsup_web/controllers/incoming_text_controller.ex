defmodule ThumbsupWeb.IncomingTextController do
  use ThumbsupWeb, :controller

  alias Thumbsup.Surveys
  alias Thumbsup.Surveys.IncomingText
  alias Thumbsup.Accounts

  action_fallback ThumbsupWeb.FallbackController

  def bandwidth_create(conn, params) do
    with {:ok, %IncomingText{} = incoming_text} <- Surveys.create_incoming_text(bandwidth_incoming_text_params(params)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", incoming_text_path(conn, :show, incoming_text))
      |> render("show.json", incoming_text: incoming_text)
    end
  end

  def assign_user(conn, params) do
    user_id = Accounts.get_user_by_phone_number(params[:from]).id
    assign(conn, :user_id, user_id)
  end

  def bandwidth_incoming_text_params(params) do
    %{user_id: params[:user_id], body: params[:text]}
  end
end
