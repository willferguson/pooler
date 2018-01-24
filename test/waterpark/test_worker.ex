defmodule Waterpark.TestWorker do
  use GenServer

  def start_link(args) do
    IO.puts("Starting Test Worker")
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    IO.puts("Starting worker with #{inspect(args)}")
    send(self(), {:slow, args})
    {:ok, args}
  end

  def call({:test, val}) do
    
  end

  def handle_info({:slow, time}, state) do
    IO.puts("#{inspect(self())} sleeping for #{time}ms")
    :timer.sleep(time)
    IO.puts("#{inspect(self())} finished sleeping, exiting")
    {:stop, :normal, state}
  end
end
