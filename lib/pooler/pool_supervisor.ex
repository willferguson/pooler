defmodule Pooler.PoolSupervisor do
  use Supervisor

  def start_link(pool_name, worker_limit, worker_mfa) do
    Supervisor.start_link(__MODULE__, {pool_name, worker_limit, worker_mfa})
  end

  #Starts a Pool Server passing the pool name, worker info and this
  #supervisor's pid - to be used to attach the worker supervisor
  def init({pool_name, worker_limit, worker_mfa}) do
    #Supervisor.init(
    #  [{Pooler.PoolServer,
    #    [pool_name, worker_limit, self(), worker_mfa]}],
    #    strategy: :one_for_all,
    #    max_restarts: 1,
    #    max_seconds: 3600)
    {:ok,{%{intensity: 1, period: 3600, strategy: :one_for_all},[%{id: Pooler.PoolServer, restart: :permanent, shutdown: 5000, start: {Pooler.PoolServer, :start_link, ["a", "b", self(), "c"]}, type: :worker}]}}
  end

end


#Supervisor.init([{Pooler.PoolServer,["a", "b", self(), "c"]}],strategy: :one_for_all,max_restarts: 1, max_seconds: 3600)
