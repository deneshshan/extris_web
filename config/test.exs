use Mix.Config

config :extris_web, ExtrisWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
