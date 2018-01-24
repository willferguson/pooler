defmodule Waterpark do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Waterpark.Pool.registry_name()},
      Waterpark.Owner
    ]

    Logger.info(fn -> "Starting waterpark" end)
    Supervisor.start_link(children, strategy: :one_for_all)
  end
end
