defmodule Waterpark.Lifeguard do
  use Supervisor
  require Logger

  @moduledoc """
    Responsible for supervising the workers in the pool
  """

  @doc """
    Starts the lifeguard with the type of worker this supervisor will supervise
  """
  def start_link(mfa) do
    Logger.info(fn -> "Starting #{__MODULE__} with: #{inspect(mfa)}" end)
    Supervisor.start_link(__MODULE__, mfa)
  end

  @doc """

  """
  def init({module, function, args}) do
    worker_child_spec =
      Supervisor.child_spec(
        module,
        start: {module, function, args},
        restart: :temporary
      )

    spec =
      Supervisor.init(
        [worker_child_spec],
        strategy: :simple_one_for_one,
        max_restarts: 5,
        max_seconds: 3600
      )

    Logger.debug(fn -> "Initialising #{__MODULE__} with #{inspect(spec)}" end)
    spec
  end
end
