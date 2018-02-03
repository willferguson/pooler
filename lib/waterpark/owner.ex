defmodule Waterpark.Owner do
  require Logger
  use Supervisor

  @moduledoc """
    Owner of the waterpark - responsible for creating and destroying pools.
  """

  def start_link(_) do
    Logger.info(fn -> "Starting #{__MODULE__}" end)
    Supervisor.start_link(__MODULE__, [], name: :waterpark_owner)
  end

  def stop do
    Supervisor.stop(:waterpark_owner, :normal, 1000)
  end

  def init(_) do
    Supervisor.init(
      [],
      strategy: :one_for_one,
      max_restarts: 5,
      max_seconds: 3600
    )
  end

  @doc """
  Creates a pool, by starting a pool supervisor and passing the worker details.
  """
  def create_pool(pool_name, worker_limit, worker_mfa) do
    child_spec =
      Supervisor.child_spec(
        Waterpark.PoolSupervisor,
        id: pool_name,
        restart: :permanent,
        start: {Waterpark.PoolSupervisor, :start_link, [pool_name, worker_limit, worker_mfa]}
      )

    Logger.debug(fn -> "Starting pool with spec: #{inspect(child_spec)}" end)
    Supervisor.start_child(:waterpark_owner, child_spec)
  end

  def remove_pool(pool_name) do
    Logger.info(fn -> "Shutting down #{pool_name}" end)
    Supervisor.terminate_child(:waterpark_owner, pool_name)
    Supervisor.delete_child(:waterpark_owner, pool_name)
  end

  def pool_count() do
    Supervisor.count_children(:waterpark_owner).active
  end
end
