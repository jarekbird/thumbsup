# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Thumbsup.Repo.insert!(%Thumbsup.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Thumbsup.Repo
alias Thumbsup.Accounts.User
alias Thumbsup.Surveys.Question
alias Thumbsup.Surveys.Prequestion

Repo.insert! %User{first_name: "Jarek", last_name: "Bird", phone_number: "+13853351955"}

question = Repo.insert! %Question{text: "Do you feel respected by others at work?"}
Repo.insert! %Prequestion{text: "R-E-S-P-E-C-T! Answer this real quick for me!", question_id: question.id}
Repo.insert! %Prequestion{text: "You deserve all the respect in the world.", question_id: question.id}
Repo.insert! %Prequestion{text: "What's with kids today? No respect!", question_id: question.id}
Repo.insert! %Prequestion{text: "Put some respeck on it!", question_id: question.id}

