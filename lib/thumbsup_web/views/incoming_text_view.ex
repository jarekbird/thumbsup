defmodule ThumbsupWeb.IncomingTextView do
  use ThumbsupWeb, :view
  alias ThumbsupWeb.IncomingTextView

  def render("index.json", %{incoming_texts: incoming_texts}) do
    %{data: render_many(incoming_texts, IncomingTextView, "incoming_text.json")}
  end

  def render("show.json", %{incoming_text: incoming_text}) do
    %{data: render_one(incoming_text, IncomingTextView, "incoming_text.json")}
  end

  def render("incoming_text.json", %{incoming_text: incoming_text}) do
    %{id: incoming_text.id,
      body: incoming_text.body,
      phone_number: incoming_text.phone_number}
  end
end
