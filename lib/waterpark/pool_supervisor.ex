defmodule Waterpark.PoolSupervisor do
  use Supervisor
  require Logger

  @moduledoc """
    Supervises a pool and pool lifeguard
  """

  def start_link(pool_name, worker_limit, worker_mfa) do
    Logger.info(fn -> "Starting pool supervisor for #{inspect(pool_name)}" end)
    Supervisor.start_link(__MODULE__, {pool_name, worker_limit, worker_mfa})
  end

  # Starts a Pool passing the pool name, worker info and this
  # supervisor's pid - to be used to attach the worker supervisor
  def init({pool_name, worker_limit, worker_mfa}) do
    Supervisor.init(
      [{Waterpark.Pool, [pool_name, worker_limit, self(), worker_mfa]}],
      strategy: :one_for_all,
      max_restarts: 1,
      max_seconds: 3600
    )
  end
end
