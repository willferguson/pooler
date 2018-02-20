defmodule Waterpark.TestWorker do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def stop(server) do
    GenServer.stop(server)
  end

  def init(args) do
    Logger.info("TestWorker started with args: #{inspect(args)}")
    {:ok, args}
  end

end
