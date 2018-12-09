# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :thumbsup,
  ecto_repos: [Thumbsup.Repo]

# Configures the endpoint
config :thumbsup, ThumbsupWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2mqez6LeqNySVnHiUWlR09NTpTGRvPua/rr2Bn5PTStRZ9oYfXy42+b30AkjKb/r",
  render_errors: [view: ThumbsupWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Thumbsup.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
