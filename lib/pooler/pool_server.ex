defmodule Pooler.PoolServer do
  use GenServer

  def start_link([pool_name, worker_limit, supervisor_pid, worker_mfa] = args) do
    IO.puts("Starting PoolServer with #{pool_name}, #{worker_limit}, #{worker_mfa} on #{inspect(supervisor_pid)}")
    GenServer.start_link(__MODULE__, args, name: pool_name)
  end

  def init([pool_name, worker_limit, supervisor_pid, worker_mfa] = args) do
    IO.puts("Init Pool")
    {:ok, args}
  end

end
