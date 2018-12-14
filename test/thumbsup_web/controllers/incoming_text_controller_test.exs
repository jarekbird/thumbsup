defmodule ThumbsupWeb.IncomingTextControllerTest do
  use ThumbsupWeb.ConnCase

  alias Thumbsup.Surveys
  alias Thumbsup.Surveys.IncomingText

  @create_attrs %{body: "some body", phone_number: "some phone_number"}
  @update_attrs %{body: "some updated body", phone_number: "some updated phone_number"}
  @invalid_attrs %{body: nil, phone_number: nil}

  def fixture(:incoming_text) do
    {:ok, incoming_text} = Surveys.create_incoming_text(@create_attrs)
    incoming_text
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all incoming_texts", %{conn: conn} do
      conn = get conn, incoming_text_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create incoming_text" do
    test "renders incoming_text when data is valid", %{conn: conn} do
      conn = post conn, incoming_text_path(conn, :create), incoming_text: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, incoming_text_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body",
        "phone_number" => "some phone_number"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, incoming_text_path(conn, :create), incoming_text: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update incoming_text" do
    setup [:create_incoming_text]

    test "renders incoming_text when data is valid", %{conn: conn, incoming_text: %IncomingText{id: id} = incoming_text} do
      conn = put conn, incoming_text_path(conn, :update, incoming_text), incoming_text: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, incoming_text_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body",
        "phone_number" => "some updated phone_number"}
    end

    test "renders errors when data is invalid", %{conn: conn, incoming_text: incoming_text} do
      conn = put conn, incoming_text_path(conn, :update, incoming_text), incoming_text: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete incoming_text" do
    setup [:create_incoming_text]

    test "deletes chosen incoming_text", %{conn: conn, incoming_text: incoming_text} do
      conn = delete conn, incoming_text_path(conn, :delete, incoming_text)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, incoming_text_path(conn, :show, incoming_text)
      end
    end
  end

  defp create_incoming_text(_) do
    incoming_text = fixture(:incoming_text)
    {:ok, incoming_text: incoming_text}
  end
end
