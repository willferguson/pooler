defmodule Waterpark do
  use Application
  require Logger

  @moduledoc """
    Entrypoint to application and API facade to enable easier management.
    This module contains all "public" functions necessary to start pools and workers
  """

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

  def enqueue(pool_name, args) do
    Waterpark.Pool.enqueue(pool_name, args)
  end

  def status(pool_name) do
    Waterpark.Pool.status(pool_name)
  end

  def stop do
    Waterpark.Owner.stop()
    System.stop()
  end

  def pool_count() do
    Waterpark.Owner.pool_count()
  end
end
