defmodule Waterpark.WaterparkTest do
  use ExUnit.Case

  setup do
    Application.start(Waterpark)
    :ok
  end

  test "Start test worker" do
    Waterpark.Owner.create_pool("test_pool", 3, {Waterpark.TestWorker, :start_link, []})
    {:ok, pid1} = Waterpark.Pool.run("test_pool", ["1"])
    {:ok, pid2} = Waterpark.Pool.run("test_pool", ["2"])
    {:ok, pid3} = Waterpark.Pool.run("test_pool", ["3"])
    {:error, _reason} = Waterpark.Pool.run("test_pool", ["too_much"])
  end
end
