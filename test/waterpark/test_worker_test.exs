defmodule Waterpark.TestWorker do
  use GenServer

  def start_link(args) do
    IO.puts("Starting Test Worker...")
    GenServer.start_link(__MODULE__, args)
  end

  def stop(server) do
    GenServer.stop(server)
  end

  def init(args) do
    # send(self(), :test)
    {:ok, args}
  end

  def handle_info(:test, state) do
    :timer.sleep(2500)
    {:stop, :normal, state}
  end
end
