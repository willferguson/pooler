defmodule Waterpark.WaterparkTest do
  use ExUnit.Case

  setup do
    Application.start(Waterpark)
    :ok
  end

  test "Start test worker" do
    Waterpark.create_pool("test_pool", 3, {Waterpark.TestWorker, :start_link, []})
    {:ok, pid1} = Waterpark.run("test_pool", [[]])
    {:ok, pid2} = Waterpark.run("test_pool", ["2"])
    {:ok, pid3} = Waterpark.run("test_pool", ["3"])
    {:error, _reason} = Waterpark.run("test_pool", ["too_much"])
  end
end
