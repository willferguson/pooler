defmodule Pooler.PoolSuperSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :ppool)
  end

  def stop do
    Supervisor.stop(:ppool, :normal, 1000)
  end

  def init(_) do
    Supervisor.init([], strategy: :one_for_one)
  end

  @doc """
  Starts a pool, by starting a pool supervisor and passing the worker details.
  """
  def start_pool(pool_name, worker_limit, worker_mfa) do

    child_spec = Supervisor.child_spec(
      Pooler.PoolSupervisor,
      id: pool_name,
      start: {Pooler.PoolSupervisor, :start_link, [[pool_name, worker_limit, worker_mfa]]})

    Supervisor.start_child(:ppool, child_spec)


  end


  def stop_pool(pool_name) do
    Supervisor.terminate_child(:ppool, pool_name)
    Supervisor.delete_child(:ppool, pool_name)
  end


end
