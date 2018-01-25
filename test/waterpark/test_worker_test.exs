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
    {:ok, args}
  end

end
