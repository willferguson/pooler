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

  def create_pool(pool_name, worker_limit, worker_mfa) do
    Waterpark.Owner.create_pool(pool_name, worker_limit, worker_mfa)
  end

  def remove_pool(pool_name) do
    Waterpark.Owner.remove_pool(pool_name)
  end

  def run(pool_name, args) do
    Waterpark.Pool.run(pool_name, args)
  end

  def stop do
    Waterpark.Owner.stop()
    System.stop()
  end
end
