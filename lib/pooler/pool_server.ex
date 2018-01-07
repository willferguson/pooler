defmodule Pooler.PoolServer do
  use GenServer

  def start_link(a, b, c, d) do
    #IO.puts("Starting PoolServer with #{pool_name}, #{worker_limit}, #{worker_mfa} on #{inspect(supervisor_pid)}")
    IO.puts("Starting...#{inspect(a)}")
  end

end
