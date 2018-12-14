defmodule Thumbsup.SurveysTest do
  use Thumbsup.DataCase

  alias Thumbsup.Surveys

  describe "questions" do
    alias Thumbsup.Surveys.Question

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Surveys.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Surveys.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Surveys.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Surveys.create_question(@valid_attrs)
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, question} = Surveys.update_question(question, @update_attrs)
      assert %Question{} = question
      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_question(question, @invalid_attrs)
      assert question == Surveys.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Surveys.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Surveys.change_question(question)
    end
  end

  describe "conversations" do
    alias Thumbsup.Surveys.Conversation

    @valid_attrs %{state: 42}
    @update_attrs %{state: 43}
    @invalid_attrs %{state: nil}

    def conversation_fixture(attrs \\ %{}) do
      {:ok, conversation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Surveys.create_conversation()

      conversation
    end

    test "list_conversations/0 returns all conversations" do
      conversation = conversation_fixture()
      assert Surveys.list_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert Surveys.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      assert {:ok, %Conversation{} = conversation} = Surveys.create_conversation(@valid_attrs)
      assert conversation.state == 42
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      assert {:ok, conversation} = Surveys.update_conversation(conversation, @update_attrs)
      assert %Conversation{} = conversation
      assert conversation.state == 43
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_conversation(conversation, @invalid_attrs)
      assert conversation == Surveys.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = Surveys.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = Surveys.change_conversation(conversation)
    end
  end

  describe "prequestions" do
    alias Thumbsup.Surveys.Prequestion

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def prequestion_fixture(attrs \\ %{}) do
      {:ok, prequestion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Surveys.create_prequestion()

      prequestion
    end

    test "list_prequestions/0 returns all prequestions" do
      prequestion = prequestion_fixture()
      assert Surveys.list_prequestions() == [prequestion]
    end

    test "get_prequestion!/1 returns the prequestion with given id" do
      prequestion = prequestion_fixture()
      assert Surveys.get_prequestion!(prequestion.id) == prequestion
    end

    test "create_prequestion/1 with valid data creates a prequestion" do
      assert {:ok, %Prequestion{} = prequestion} = Surveys.create_prequestion(@valid_attrs)
      assert prequestion.text == "some text"
    end

    test "create_prequestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_prequestion(@invalid_attrs)
    end

    test "update_prequestion/2 with valid data updates the prequestion" do
      prequestion = prequestion_fixture()
      assert {:ok, prequestion} = Surveys.update_prequestion(prequestion, @update_attrs)
      assert %Prequestion{} = prequestion
      assert prequestion.text == "some updated text"
    end

    test "update_prequestion/2 with invalid data returns error changeset" do
      prequestion = prequestion_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_prequestion(prequestion, @invalid_attrs)
      assert prequestion == Surveys.get_prequestion!(prequestion.id)
    end

    test "delete_prequestion/1 deletes the prequestion" do
      prequestion = prequestion_fixture()
      assert {:ok, %Prequestion{}} = Surveys.delete_prequestion(prequestion)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_prequestion!(prequestion.id) end
    end

    test "change_prequestion/1 returns a prequestion changeset" do
      prequestion = prequestion_fixture()
      assert %Ecto.Changeset{} = Surveys.change_prequestion(prequestion)
    end
  end

  describe "incoming_texts" do
    alias Thumbsup.Surveys.IncomingText

    @valid_attrs %{body: "some body", phone_number: "some phone_number"}
    @update_attrs %{body: "some updated body", phone_number: "some updated phone_number"}
    @invalid_attrs %{body: nil, phone_number: nil}

    def incoming_text_fixture(attrs \\ %{}) do
      {:ok, incoming_text} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Surveys.create_incoming_text()

      incoming_text
    end

    test "list_incoming_texts/0 returns all incoming_texts" do
      incoming_text = incoming_text_fixture()
      assert Surveys.list_incoming_texts() == [incoming_text]
    end

    test "get_incoming_text!/1 returns the incoming_text with given id" do
      incoming_text = incoming_text_fixture()
      assert Surveys.get_incoming_text!(incoming_text.id) == incoming_text
    end

    test "create_incoming_text/1 with valid data creates a incoming_text" do
      assert {:ok, %IncomingText{} = incoming_text} = Surveys.create_incoming_text(@valid_attrs)
      assert incoming_text.body == "some body"
      assert incoming_text.phone_number == "some phone_number"
    end

    test "create_incoming_text/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_incoming_text(@invalid_attrs)
    end

    test "update_incoming_text/2 with valid data updates the incoming_text" do
      incoming_text = incoming_text_fixture()
      assert {:ok, incoming_text} = Surveys.update_incoming_text(incoming_text, @update_attrs)
      assert %IncomingText{} = incoming_text
      assert incoming_text.body == "some updated body"
      assert incoming_text.phone_number == "some updated phone_number"
    end

    test "update_incoming_text/2 with invalid data returns error changeset" do
      incoming_text = incoming_text_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_incoming_text(incoming_text, @invalid_attrs)
      assert incoming_text == Surveys.get_incoming_text!(incoming_text.id)
    end

    test "delete_incoming_text/1 deletes the incoming_text" do
      incoming_text = incoming_text_fixture()
      assert {:ok, %IncomingText{}} = Surveys.delete_incoming_text(incoming_text)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_incoming_text!(incoming_text.id) end
    end

    test "change_incoming_text/1 returns a incoming_text changeset" do
      incoming_text = incoming_text_fixture()
      assert %Ecto.Changeset{} = Surveys.change_incoming_text(incoming_text)
    end
  end
end
