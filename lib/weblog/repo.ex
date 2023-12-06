defmodule Weblog.Repo do
  use Ecto.Repo,
    otp_app: :weblog,
    adapter: Ecto.Adapters.SQLite3
end
